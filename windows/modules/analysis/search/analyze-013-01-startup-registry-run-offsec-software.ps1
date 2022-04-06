
# Script : Invoke-PowerHunt
# Module : analyze-startup-registry-run-offsec-software
# Version: 1.0
# Author : Scott Sutherland
# Summary: This is script is part of the PowerHunt framework. This filters for keywords associated with common security related software used by threat actors.
# License: 3-clause BSD

$AnalysisModuleDesc = "Place holder description."

# Import strings
$TargetStrings = gc .\windows\modules\lists\list-offsec-software.txt

# Generate filter from keywords
$Filter = 'where {('
$TargetStrings |
foreach{
    $Filter = $Filter + '$_.FilePath -like "*' + $_ + '*" -or '
}
$Filter = $Filter + '$_.FilePath -like ""' + ")}"

# Build PS query
$PsQuery = '$CollectedData | ' +  $Filter

# Run PS query
$AnalysisResult = Invoke-Expression $PsQuery 

# Save result details
$AnalysisModuleFileName = $_.name -replace(".ps1",".csv")
$Time =  Get-Date -UFormat "%m/%d/%Y %R"
$AnalysisResult | Export-Csv -NoTypeInformation "$OutputDirectory\analysis\$AnalysisSubDir\Hunt-$AnalysisModuleFileName"

# Save result summary
$AnalysisModuleFileName = $_.name -replace(".ps1","-counts.csv")
$FinalOutput = $AnalysisResult | group FilePath | Sort-Object count -Descending | select count,name 
$FinalOutput | Export-Csv -NoTypeInformation "$OutputDirectory\analysis\$AnalysisSubDir\Hunt-$AnalysisModuleFileName"

# Count instances
$InstanceCount = $FinalOutput | measure | select count -expandproperty count

# Count affected computers 
$AnalysisModuleAffectedComputerCount = $FinalOutput | select PSComputerName -Unique | measure | select count -ExpandProperty count                    

# Save summary metrics
$null = $ModuleOutputSummary.Rows.Add("$ModuleType","$CollectionModuleName","$CollectionDataSource","$AnalysisModuleName","$AnalysisModuleDesc","$AnalysisType","$InstanceCount","$AnalysisModuleAffectedComputerCount")


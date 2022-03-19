# Invoke-HuntPersistPR
Invoke-HuntPersistPR is a modular hunting framework written in PowerShell designed to: 
* Discover accessible systems associated with a Active Directory domain  automatically
* Collect data source information from systems using PowerShell Remoting and easy to build collection modules
* Analyze collected data using easy to build analysis modules 
* Generate summary report that includes initial insights that can help analysts get a jump start on simple threat hunting exercises that focus on common persistence and related techniques

This is not a novel idea, but I thought it was worth sharing for those who may be interested in playing with it. 
User and developer guides can be found on the wiki  <a href="https://github.com/NetSPI/Invoke-HuntPersistPR/wiki">here</a>.<Br>

<strong>Author</strong><Br>
Scott Sutherland (@_nullbind) <Br>

<strong>License</strong><Br>
BSD 3-Clause

## TODO
* Finalize credentials passthrough to ldap and remoting sessions
* Add single target
* Add group of targets
* Add -OnlyCollection flag
* Add -OnlyAnalysis -SourcePath flags
* Create an HTML summary report (summary for disco, collection, analysis; main page for each with dig in html files)
  * update collect-process to include owner pesecurity information
* add analysis-process-outlier-file-owner
* add analysis-process-lobas
* add analysis-task-author-run-user-mismatch
* add analysis-task-outliers-owner
* add analysis-task-outliers-user
* add analysis-task-outliers-creation
* add analysis-service-account-user
* update collect-startup-files-allusers to cover more directories
* update collect-startup-registry-run to cover HKU, not just HKLM
* add execution flow diagram
* update baked in help





# Invoke-HuntPersistPR
Invoke-HuntPersistPR is a PowerShell framework designed to use PowerShell Remoting to collect and analyze data at the beginning of threat hunting exercises that focus on common persistence and related techniques. This script is intended to be used by security teams that can operate from a privileged context within their Active Directory domain.  This is not a novel idea, but I thought it was worth sharing for those who may be interested in playing with it.

## Requirements
* Domain user credentials
* Administrative privileges on the collection targets and local system
* PowerShell Remoting must be enabled and accessible on the target systems

## Setup Instructions
* Download the full project with subdirectories to the system that you will be running the data collection from.
* Import the Invoke-HuntPersistPR.psm1 script.
* Run the command with the desired parameters.

## Command Examples

### Domain Joined System
#### Example 1
The example below shows the syntax for running the script from a domain joined system without providing alternative credentials or a specific domain controller.
<pre>
Invoke-HuntPersistPR -OutputDirectory "c:\temp" -Threads 100 
</pre>

#### Example 2
The example below shows the syntax for running the script from a domain joined system while providing a specific domain controller.
<pre>
Invoke-HuntPersistPR -OutputDirectory "c:\temp" -Threads 100 -DomainController 10.1.1.1
</pre> 

#### Example 3
The example below shows the syntax for running the script from a domain joined system using alternative credentials.
<pre>
Invoke-HuntPersistPR -OutputDirectory "c:\temp" -Threads 100 -DomainController 10.1.1.1 -Credentials domain\user
</pre> 

### Non Domain Joined System
#### Example 1
The example below shows the syntax for running the script from a system that has NOT been joined to the target domain.
<pre>
runas /netonly /user:domain\user powershell.exe
Invoke-HuntPersistPR -Threads 100 -OutputDirectory c:\temp -DomainController 10.1.1.1 -Username domain\user -password 'password'
</pre>

#### Example 2
The example below shows the syntax for running the script from a domain joined system using alternative credentials.
<pre>
runas /netonly /user:domain\user powershell.exe
Invoke-HuntPersistPR -OutputDirectory "c:\temp" -Threads 100 -DomainController 10.1.1.1 -Credentials domain\user
</pre> 

## Invoke-HuntPersistPR Output
Below is a summary of the output generated from Invoke-HuntPersistPR. Each run of the script will generate its own folder that includes the domain and the associated date/timestamp.  Files generated from Invoke-HuntPersistPR can be found in the following directories:
|Directory|Description
|:-------------------------------------------------------|:-----------
|\discovery|Files contianing active domain computers with PS remoting enabled sampled during testing.
|\collection|Files containing collected data from targeted data sources that can be analyzed offline.
|\analysis|Invoke-HuntPersistPR will filter the collected data using the analysis modules and generate .csv files that can be analyzed offline.

#### Command Output Example
<pre>
Invoke-HuntPersistPR -Threads 100 -OutputDirectory c:\temp\now
 ===========================================
 INVOKE-HUNTPERSISTPR
 ===========================================
 [+][03/18/2022 17:35] Start active testing
 -------------------------------------------
 ENABLING POWERSHELL REMOTING
 -------------------------------------------
 [+][03/18/2022 17:35] Confirmed local administrative privileges.
 [+][03/18/2022 17:35] Checking if PS Remoting is enabled...
 [+][03/18/2022 17:35] PS Remoting appears to be enabled.
 [+][03/18/2022 17:35] Local PowerShell Remoting requirements met.
 -------------------------------------------
 DISCOVERY: DOMAIN COMPUTERS - LDAP QUERY
 -------------------------------------------
 [+][03/18/2022 17:35] Attempting to access domain controller...
 [+][03/18/2022 17:35] Successful connection to domain controller: WIN-72A3HMP6OLO.DEMO.LOCAL
 [+][03/18/2022 17:35] Performing LDAP query for computers associated with the DEMO.LOCAL domain
 [+][03/18/2022 17:35] - 3 computers found
 [+][03/18/2022 17:35] Output directory: c:\temp\now\DEMO.LOCAL-031820221735
 -------------------------------------------
 DISCOVERY: DOMAIN COMPUTERS - PING SCANS
 -------------------------------------------
 [+][03/18/2022 17:35] Pinging 3 computers
 [+][03/18/2022 17:35] - 3 computers responded to ping requests.
 -------------------------------------------
 DISCOVERY: DOMAIN COMPUTERS - PORT SCANS
 -------------------------------------------
 [+][03/18/2022 17:35] Checking if TCP Port 5985 (NonSSL) is open on 3 computers
 [+][03/18/2022 17:35] - 3 computers have TCP port 5985 open.
 [+][03/18/2022 17:35] Checking if TCP Port 5986 (SSL) is open on 3 computers
 [+][03/18/2022 17:35] - 0 computers have TCP port 5986 open.
 [+][03/18/2022 17:35] Creating PS Remoting Target List.
 [+][03/18/2022 17:35] - 3 computers will be targeted.
 -------------------------------------------
 COLLECTION: ESTABLISH PS REMOTING SESSIONS
 -------------------------------------------
 [+][03/18/2022 17:35] - Attempting to establish PS Remoting sessions with 3 systems.
 [+][03/18/2022 17:35] - 3 PS Remoting sessions were established.
 -------------------------------------------
 COLLECTION: RUN ALL MODULES
 -------------------------------------------
 [+][03/18/2022 17:35] 11 collection modules will be run against 3 sessions.
 [+][03/18/2022 17:35] (1 of 11) collect-events-1102
 [+][03/18/2022 17:35] (2 of 11) collect-events-4732
 [+][03/18/2022 17:35] (3 of 11) collect-installed-software
 [+][03/18/2022 17:35] (4 of 11) collect-named-pipes
 [+][03/18/2022 17:35] (5 of 11) collect-process
 [+][03/18/2022 17:35] (6 of 11) collect-services
 [+][03/18/2022 17:36] (7 of 11) collect-startup-files-allusers
 [+][03/18/2022 17:36] (8 of 11) collect-startup-registry-run
 [+][03/18/2022 17:36] (9 of 11) collect-tasks
 [+][03/18/2022 17:36] (10 of 11) collect-wmi-providers
 [+][03/18/2022 17:36] (11 of 11) collect-wmi-subscriptions
 -------------------------------------------
 ANALYSIS: RUN ALL MODULES
 -------------------------------------------
 [+][03/18/2022 17:37] 33 analysis modules will be run against 11 data sources.
 [+][03/18/2022 17:37] Data Source (1 of 11): events-1102
 [+][03/18/2022 17:37] - No analysis modules exist for this data source.
 [+][03/18/2022 17:37] Data Source (2 of 11): events-4732
 [+][03/18/2022 17:37] - 4 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 4) analyze-events-4732-add-user-by-remotecomputer
 [+][03/18/2022 17:37] - (2 of 4) analyze-events-4732-add-user-by-workgroup
 [+][03/18/2022 17:37] - (3 of 4) analyze-events-4732-add-user-computeraccount
 [+][03/18/2022 17:37] - (4 of 4) analyze-events-4732-add-user
 [+][03/18/2022 17:37] Data Source (3 of 11): installed-software
 [+][03/18/2022 17:37] - 2 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 2) analyze-installed-software-mgmt
 [+][03/18/2022 17:37] - (2 of 2) analyze-installed-software-offsec
 [+][03/18/2022 17:37] Data Source (4 of 11): named-pipes
 [+][03/18/2022 17:37] - 1 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 1) analyze-named-pipes-known-bad
 [+][03/18/2022 17:37] Data Source (5 of 11): process
 [+][03/18/2022 17:37] - No analysis modules exist for this data source.
 [+][03/18/2022 17:37] Data Source (6 of 11): services
 [+][03/18/2022 17:37] - 7 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 7) analyze-services-badpath
 [+][03/18/2022 17:37] - (2 of 7) analyze-services-dotnet
 [+][03/18/2022 17:37] - (3 of 7) analyze-services-lolbas
 [+][03/18/2022 17:37] - (4 of 7) analyze-services-mgmt-software
 [+][03/18/2022 17:37] - (5 of 7) analyze-services-offsec-software
 [+][03/18/2022 17:37] - (6 of 7) analyze-services-outlier-file-owner
 [+][03/18/2022 17:37] - (7 of 7) analyze-services-unsigned
 [+][03/18/2022 17:37] Data Source (7 of 11): startup-files-allusers
 [+][03/18/2022 17:37] - 6 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 6) analyze-startup-files-allusers-dotnet
 [+][03/18/2022 17:37] - (2 of 6) analyze-startup-files-allusers-lolbas
 [+][03/18/2022 17:37] - (3 of 6) analyze-startup-files-allusers-mgmt-software
 [+][03/18/2022 17:37] - (4 of 6) analyze-startup-files-allusers-offsec-software
 [+][03/18/2022 17:37] - (5 of 6) analyze-startup-files-allusers-outlier-file-owner
 [+][03/18/2022 17:37] - (6 of 6) analyze-startup-files-allusers-unsigned
 [+][03/18/2022 17:37] Data Source (8 of 11): startup-registry-run
 [+][03/18/2022 17:37] - 7 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 7) analyze-startup-registry-run-badpath
 [+][03/18/2022 17:37] - (2 of 7) analyze-startup-registry-run-dotnet
 [+][03/18/2022 17:37] - (3 of 7) analyze-startup-registry-run-lolbas
 [+][03/18/2022 17:37] - (4 of 7) analyze-startup-registry-run-mgmt-software
 [+][03/18/2022 17:37] - (5 of 7) analyze-startup-registry-run-offsec-software
 [+][03/18/2022 17:37] - (6 of 7) analyze-startup-registry-run-outlier-file-owner
 [+][03/18/2022 17:37] - (7 of 7) analyze-startup-registry-run-unsigned
 [+][03/18/2022 17:37] Data Source (9 of 11): tasks
 [+][03/18/2022 17:37] - 6 analysis modules found, loading data source.
 [+][03/18/2022 17:37] - (1 of 6) analyze-tasks-dotnet
 [+][03/18/2022 17:37] - (2 of 6) analyze-tasks-lolbas
 [+][03/18/2022 17:37] - (3 of 6) analyze-tasks-mgmt-software
 [+][03/18/2022 17:37] - (4 of 6) analyze-tasks-offsec-software
 [+][03/18/2022 17:37] - (5 of 6) analyze-tasks-outlier-file-owner
 [+][03/18/2022 17:37] - (6 of 6) analyze-tasks-unsigned
 [+][03/18/2022 17:37] Data Source (10 of 11): wmi-providers
 [+][03/18/2022 17:37] - No analysis modules exist for this data source.
 [+][03/18/2022 17:37] Data Source (11 of 11): wmi-subscriptions
 [+][03/18/2022 17:37] - No analysis modules exist for this data source.
 -------------------------------------------
 REPORTING: RUN ALL MODULES
 -------------------------------------------
 - HTML (pending)
 -------------------------------------------
 SHUTDOWN
 -------------------------------------------
 [+][03/18/2022 17:37]  - Terminating 3 PowerShell Remoting sessions.
 [+][03/18/2022 17:37]  - Stopping active testing
 [+][03/18/2022 17:37]  - Test duration: 00:01:37.2076186
</pre>

## Invoke-HuntPersistPR Framework Structure
Below is a summary framework's directory structure.
|Path|Description
|:-------------------------------------------------------|:-----------
|Invoke-HuntPersistPR.psm1|This the primary script.
|\windows\modules\collection|This contains all Windows collection modules. Collection modules can be added here and run against targets without additional code changes to the primary script.
|\windows\modules\analysis|This contains all Windows analysis modules. Analysis modules can be added here and run against targets without additional code changes to the primary script.
|\windows\modules\lists|This contains lists of items used by analysis modules.
                
## Collection Modules
Collection modules are used query data from target systems.  They typically target a single data source. Below is a summary of the currently supported collection modules. 
|Module<Br>Name|Mitre ATT&CK ID|Module<br>Description|Collection<br>Method
|:-------------------------------------------------------|:-----------|:-----------|:-----------|
|collect-tasks|T1053.002|Collects Windows scheduled task information.|Get-ScheduledTask
|collect-services|T1569.002|Collects Windows service information.|Get-WmiObject -Class win32_service
|collect-wmi-providers|T1047|Collects WMI provider information.|Get-WmiObject -Class __Win32Provider
|collect-wmi-subscriptions|T1546.003|WMI Subscriptions|Collects WMI subscription information.|Get-WmiObject -Namespace root/subscription
|collect-startup-files-allusers|T1547.001|Collect information from all users startup folders|$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\StartUp\
|collect-startup-registry-run|T1547.001|Collect information from registry run keys|HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\
|collect-installed-software|T1505|Installed Software|Get-Software
|collect-named-pipes|T1570|Collect information from named pipes|Get-ChildItem \\.\pipe\
|collect-events-4732|T1136.001|Event 4732|Collect information from 4732 events (member added to security-enabled local group)|Get-WinEvent -FilterHashtable @{logname="security"; id="4732"}
|collect-events-1102|T1070.001|Event 1102|Collect information from 1102 events (audit log cleared)|Get-WinEvent -FilterHashtable @{logname="security"; id="1102"}
|collect-process|T1057|Collects list of running processes.|Get-WMIObject Win32_Process
  
#### Adding New Collection Modules
All collection modules are automatically loaded from the windows\modules\collection folder and ran against established PowerShell Remoting systems. You can add your own there and they will be run automatically.

## Analysis Modules 
Analysis modules are used to filter collected data in a way that makes it easier to find known threats, suspicious behavior, and environmental anomalies.  Additionally, the .csv files generated from the filtering can be consumed by another tool like Jupyter notebooks. 
|Module<br>Name|Module<br>Description|Data Source
|:-------------------------------------------------------|:-----------|:-----------|
|analyze-services-lolbas|tbd|collect-services
|analyze-services-mgmt-software|tbd|collect-services
|analyze-services-offsec-software|tbd|collect-services
|analyze-services-unsigned|tbd|collect-services
|analyze-services-dotnet|tbd|collect-services
|analyze-services-badpath|tbd|collect-services
|analyze-services-outlier-filepath|tbd|collect-services
|analyze-services-outlier-owner|tbd|collect-services
|analyze-tasks-lolbas|tbd|collect-tasks
|analyze-tasks-mgmt-software|tbd|collect-tasks
|analyze-tasks-offsec-software|tbd|collect-tasks
|analyze-tasks-unsigned|tbd|collect-tasks
|analyze-tasks-dotnet|tbd|collect-tasks
|analyze-tasks-badpath|tbd|collect-tasks
|analyze-tasks-outlier-filepath|tbd|collect-tasks
|analyze-tasks-outlier-owner|tbd|collect-tasks
|analyze-startup-registry-run-lolbas|tbd|collect-startup-registry-run
|analyze-startup-registry-run-mgmt-software|tbd|collect-startup-registry-run
|analyze-startup-registry-run-offsec-software|tbd|collect-startup-registry-run
|analyze-startup-registry-run-unsigned|tbd|collect-startup-registry-run
|analyze-startup-registry-run-dotnet|tbd|collect-startup-registry-run
|analyze-startup-registry-run-badpath|tbd|collect-startup-registry-run
|analyze-startup-registry-run-outlier-owner|tbd|collect-startup-registry-run
|analyze-startup-files-allusers-lolbas|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-mgmt-software|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-offsec-software|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-unsigned|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-dotnet|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-badpath|tbd|collect-startup-files-allusers
|analyze-startup-files-allusers-outlier-owner|tbd|collect-startup-files-allusers
|analyze-installed-software-mgmt-software|tbd|collect-installed-software
|analyze-installed-software-offsec-software|tbd|collect-installed-software
|analyze-named-pipes-known-bad|tbd|collect-named-pipes
|analyze-events-4732-add-user|tbd|collect-events-4732

#### Adding New Analysis Modules
All analysis modules are automatically loaded from the windows\modules\analysis folder and ran offline against collected data sources based on matching module names. For example, all analysis modules that start with "analysis-tasks" will be ran against the "collect-tasks" data source. It's not very elegant, but it'ss functional and seems to make adding new modules easy as long as you name them correctly. :)
  
Below is a summary of the currently supported analysis modules.   
  
## Command Benchmarks
* Based on initial testing, data collection can be completed from approximetly 2000 systems an hour.
* Please note that if analysis modules are not disabled, time to script completion may be longer.

## TODO
* fix counts ... some are pathname and some are filepath; there may be others - consider makes count analysis modules instead
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
  
## Script Authors
### Primary
Scott Sutherland (@_nullbind) <Br>
![Twitter Follow](https://img.shields.io/twitter/follow/_nullbind.svg?style=social)
### Secondardy
These individuals wrote open source code that was used as part of this project. A big thank you goes out them and their work!<br>
|Name|Site|
|:--------------------------------|:-----------|
|Eric Gruber (@egru)|https://github.com/NetSPI/PESecurity
|BoeProx (@proxb)|https://mcpmag.com/articles/2017/07/27/gathering-installed-software-using-powershell.aspx
|Will Schroeder (@harmj0y)|https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1
|Warren F (@pscookiemonster)|https://github.com/RamblingCookieMonster/Invoke-Parallel

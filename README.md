# PowerHunt
<a href="https://github.com/NetSPI/PowerHunt/wiki"><strong>PowerHunt</strong></a> is a modular threat hunting framework written in PowerShell that leverages PowerShell Remoting for data collection at scale. <br><br> 
It is designed to <strong>identify signs of compromise</strong> based on artifacts left behind by common MITRE ATT&CK techniques, and the collected data can be used to identify anomalies and outliers specific to the target environment.  <em>It was not designed to identify known bad files, domains, or IPs associated with specific APTs/malware, but I'm sure it could be extended to do that.</em> 

It supports functionality to:
* <strong>Authenticate</strong> using the current user context, a credential, or clear text user/password.
* <strong>Discover</strong> accessible systems associated with an Active Directory domain automatically.
* <strong>Target</strong> a single computer, list of computers, or discovered Active Directory computers (default).
* <strong>Collect</strong> data source information from target systems using PowerShell Remoting and easy to build collection modules.
* <strong>Analyze</strong> collected data using easy to build analysis modules based on behavior.
* <strong>Report</strong> summary data and initial insights that can help analysts get started on simple threat hunting exercises that focus on common persistence and related techniques.

This is not a novel approach to threat hunting, but I thought the project was worth sharing, because in certain environments the automation can be a time saver. <br><br>
User and developer guides can be found on the wiki  <a href="https://github.com/NetSPI/PowerHunt/wiki">here</a>.<Br>

<strong>Author</strong><Br>
Scott Sutherland (@_nullbind) <Br>

<strong>License</strong><Br>
BSD 3-Clause

Primary Todo
--
**Pending Fixes / Higher Priorities**
* Create an HTML summary report (summary for discovery(sample), collection, analysis; main page for each with dig in html files)
* Fix groups and user collection on 2008 ps3 vs ps5 - function used are not backwards compatable
* Fix cast error in field for wmi bindings modules
* Update $AnalysisModuleDesc in each analysis module to include correct description.
* Review events for potential additions https://github.com/ANSSI-FR/guide-journalisation-microsoft/blob/main/Standard_WEC_query.xml
  
**Pending Features / Modules**

Collection
* Add RDP session collection
* Add PS remoting session collection
* Add netsess session collection
  
Analysis / Core
* Add thresholds to all anomaly modules - make configurable.
  
Report.
* Excludede DC option.
* Create square chart, with color desity associated with instances per subnets/system
* Heat map chart.
* Timeline chart.
  


  








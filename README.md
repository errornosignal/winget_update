This was created to accomodate running winget upgrade as a scheduled task in Windows Task Scheduler with little to no user intervention required.  
I set my Scheduled Task to trigger on workstation unlock and call 'winget_oncePerDay_invis.vbs' once per day using wscript.exe.  

<ins>Scheduled Task Details:<ins>  
- General
> Run only when user is logged on, Run with highest priviledges  
- Triggers
> Begin the task: On workstation unlock, Enabled  
- Actions
> Action: Start a program,  
> Program/script: wscript.exe,  
> Add arguments: winget_oncePerDay_invis.vbs,  
> Start in: PATH_TO_'winget_oncePerDay_invis.vbs'  

<ins>How it works:<ins>  
- Run winget upgrade silently by calling 'winget_oncePerDay_invis.vbs'.  
- Calling 'winget_oncePerDay_invis.vbs' then silently calls 'winget_oncePerDay.ps1'.  
- When 'winget_oncePerDay.ps1' is called on first run, the script then inserts today's date into 'winget-task_LastRunDate.txt', then proceeds to call 'winget_upgrade.bat'.  
- 'winget_upgrade.bat' runs winget upgrade and logs the output to winget_upgrade_log.txt.  
- If 'winget_oncePerDay.ps1' is run again, but the log file 'winget-task_LastRunDate.txt' already contains today's date, the execution of 'winget_upgrade.bat' will be skipped.  

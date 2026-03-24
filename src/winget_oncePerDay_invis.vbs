Set objShell = CreateObject("WScript.Shell")  
objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""%UserProfile%\OneDrive\Documents\Scripts\winget\winget_oncePerDay.ps1""", 0, False 
 
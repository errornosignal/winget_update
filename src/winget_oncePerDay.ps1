# PowerShell Script: winget-task_oncePerDay.ps1
# Ensures a Winget task runs only once per day

# Define log file path (ensure the folder exists)
$logFile = "winget-task_LastRunDate.txt"
$today = (Get-Date).ToString('yyyy-MM-dd')

# Check if log file exists, and read the last run date
$lastRunDate = if (Test-Path $logFile) { Get-Content $logFile -ErrorAction SilentlyContinue | Select-Object -First 1 } else { "" }

# Run the Winget task if it hasn't run today
if ($lastRunDate -ne $today) {
    #Write-Output "Running Winget task for the day: $today" #commented for silent running

    # Replace below with your actual Winget task, e.g., upgrading apps
    Start-Process "cmd.exe" "/c `"winget_upgrade.bat`"" -NoNewWindow

    # Update the log file with today's date
    try {
        $today | Out-File -FilePath $logFile -Force -Encoding UTF8
    } catch {
        Write-Error "Failed to write log file: $_"
    }
} else {
    #Write-Output "Winget task has already run today ($today). Skipping." #commented for silent running
}

# Optional: keep the window open if running manually
#Read-Host -Prompt "Press any key to exit" #commented for silent running
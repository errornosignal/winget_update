@echo off
REM ============================================================
REM Winget Upgrade Script - Updates all installed packages
REM Requires: Windows 10/11 with Winget installed
REM ============================================================

:: Enable UTF-8 for proper output display
chcp 65001 >nul

:: Set log file path (same folder as script)
set "LOGFILE=%~dp0winget_upgrade_log.txt"

echo =========================================================== >> "%LOGFILE%"
echo [%date% %time%] Starting Winget Upgrade >> "%LOGFILE%"
echo =========================================================== >> "%LOGFILE%"

:: Check if winget is available
where winget >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Winget is not installed or not in PATH.
    echo [ERROR] Winget is not installed or not in PATH. >> "%LOGFILE%"
    pause
    exit /b 1
)

:: Display packages that will be upgraded
echo Checking for available updates...
winget upgrade >> "%LOGFILE%" 2>&1

:: Run upgrade for all packages without confirmation
echo Running: winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --include-unknown --include-pinned --verbose
winget upgrade --all --silent --accept-package-agreements --accept-source-agreements --include-unknown --include-pinned --verbose >> "%LOGFILE%" 2>&1

:: Check exit code
if %errorlevel% equ 0 (
    echo [%date% %time%] Upgrade completed successfully. >> "%LOGFILE%"
    echo ✅ All packages upgraded successfully.
) else (
    echo [%date% %time%] Upgrade encountered errors. Exit code: %errorlevel% >> "%LOGFILE%"
    echo ⚠ Some upgrades failed. Check the log file for details: "%LOGFILE%"
)

echo =========================================================== >> "%LOGFILE%"
echo. >> "%LOGFILE%"

pause
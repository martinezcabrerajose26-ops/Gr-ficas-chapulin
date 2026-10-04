@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0abrir-dashboard.ps1"
if errorlevel 1 (
  echo.
  pause
)

@echo off
setlocal enabledelayedexpansion

set chars=abcdefghijklmnopqrstuvwxyz0123456789
set network_SSID=WiFi_Network_Name

:bruteforce
set password=
for /l %%i in (1,1,8) do (
    set /a index=!random! %% 36
    for /l %%j in (!index!,1,!index!) do set "password=!password!!chars:~%%j,1!"
)

netsh wlan show profile name="%network_SSID%" key=clear | findstr Key
if not errorlevel 1 (
    netsh wlan export profile key=clear > nul
    netsh wlan show profile name="%network_SSID%" key=clear | findstr Content
)

timeout /t 5 >nul
goto bruteforce

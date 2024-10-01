@echo off

set KOMOREBI_CONFIG_HOME=%USERPROFILE%\.config\komorebi

for /f "delims=" %%i in ('powershell -Command "@(Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams).Length"') do set monitor=%%i

if %monitor% == 1 (
	rem for single monitor
	komorebic start --whkd --bar
) else (
	rem for multi monitor
	komorebic start --whkd

	cd "%USERPROFILE%\git\yuu528\yasb"
	python src/main.py
)

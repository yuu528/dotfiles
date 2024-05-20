@echo off

set KOMOREBI_CONFIG_HOME=%USERPROFILE%\.config\komorebi

komorebic start --whkd

cd "%USERPROFILE%\git\yuu528\yasb"
python src/main.py

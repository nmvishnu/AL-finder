@echo off
REM Function: Windows batch file to display hostname and AlertLogic processes and services. Creates an AL_out.txt file in executed directory.
REM IMPORTANT: Requires WRITE permission within the folder from which batch file is executed.
REM Works for Standard users and Administrators. Should work for most of the Windows versions with Standard user priveilages.
REM P.S. I'm not a 'Pro' in batch scripting. Created as a quick, lazy work - DO NOT expect Updates, Fixes, etc.
REM Feel free to modify this code and use it in your work/project.

echo "Hostname:" >> AL_out.txt
hostname >> AL_out.txt

echo "==============================" >> AL_out.txt
echo "AlertLogic processes" >> AL_out.txt
echo "==============================" >> AL_out.txt

tasklist | findstr "al-agent.exe" >> AL_out.txt
tasklist | findstr "al-log-agent.exe" >> AL_out.txt
tasklist | findstr "al-threat-agent.exe" >> AL_out.txt

tasklist /FI "IMAGENAME eq al-agent.exe" 2>NUL | find /I /N "al-agent.exe">NUL
if "%ERRORLEVEL%"=="0" echo AlertLogic Universal Agent is running >> AL_out.txt

tasklist /FI "IMAGENAME eq al-log-agent.exe" 2>NUL | find /I /N "al-log-agent.exe">NUL
if "%ERRORLEVEL%"=="0" echo AlertLogic Legacy Log Manager agent is running >> AL_out.txt

tasklist /FI "IMAGENAME eq al-threat-agent.exe" 2>NUL | find /I /N "al-threat-agent.exe">NUL
if "%ERRORLEVEL%"=="0" echo AlertLogic Legacy Threat Manager agent is running >> AL_out.txt

echo "==============================" >> AL_out.txt
echo "AlertLogic services" >> AL_out.txt
echo "==============================" >> AL_out.txt

sc query query al_agent | findstr "SERVICE_NAME" >> AL_out.txt 
sc query query al_agent | findstr "STATE" >> AL_out.txt 
sc query query al_log_agent | findstr "SERVICE_NAME" >> AL_out.txt 
sc query query al_log_agent | findstr "STATE" >> AL_out.txt
sc query query "AL Threat Agent" | findstr "SERVICE_NAME" >> AL_out.txt 
sc query query "AL Threat Agent" | findstr "STATE" >> AL_out.txt 

echo "==============================" >> AL_out.txt
echo "Results saved to AL_out.txt"
echo "Press any key to exit"
pause >nul
exit


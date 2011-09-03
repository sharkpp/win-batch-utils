@echo off
setlocal

set STDOUT_TMP=%~dp0stdout

echo -------------------------------------------------------> "%STDOUT_TMP%"
echo Error reporting of cui application>>                     "%STDOUT_TMP%"
echo ------------------------------------------------------->>"%STDOUT_TMP%"
echo date: %DATE% %TIME%>>                                    "%STDOUT_TMP%"
echo command line:>>                                          "%STDOUT_TMP%"
echo   %*>>                                                   "%STDOUT_TMP%"
echo ------------------------------------------------------->>"%STDOUT_TMP%"

if /I ".cmd"=="%~x1" goto :run_batch
if /I ".bat"=="%~x1" goto :run_batch
%*>>"%STDOUT_TMP%" 2>&1
goto :error_check
:run_batch
call %*>>"%STDOUT_TMP%" 2>&1

:error_check
if errorlevel 1 goto :error_report
del "%STDOUT_TMP%"
goto :eof

:error_report
call :count_of_process notepad.exe
set PROC_NUM=%NUM%
start "" notepad "%STDOUT_TMP%"
if errorlevel 1 goto :wait_process_run_break
:wait_process_run
call :count_of_process notepad.exe
if "%NUM%"=="%PROC_NUM%" goto :wait_process_run
:wait_process_run_break
del "%STDOUT_TMP%"
goto :eof

:count_of_process
 set NUM=0
 for /F %%I in ('tasklist^|find "%1"') do set /A NUM+=1
 exit /b %NUM%

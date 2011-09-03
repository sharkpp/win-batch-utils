@echo off

rem ------------------------------------
rem git コマンドにパスを通す
rem ------------------------------------
:mktmp
set SUB_CMD=%~dp0%RANDOM%.cmd
if exist "%SUB_CMD%" goto :mktmp
setlocal
set ComSpec=/?^>nul ^& set PATH^>%SUB_CMD%
call C:\msysgit\msysgit\git-cmd.bat
endlocal
call %SUB_CMD% 2>nul 1>nul
del %SUB_CMD%
rem ------------------------------------

rem ------------------------------------
rem authorsファイルからユーザー名とメールアドレスを取得
rem ------------------------------------
set REPOS_USER=
set REPOS_EMAIL=
setlocal ENABLEDELAYEDEXPANSION
for /F "tokens=*" %%I in (%~dp0authors) do (
 set LINE=%%I&set LINE=!LINE:^<= !&set LINE=!LINE:^>= !
 for /F "tokens=1,3,4" %%J in ("!LINE!") do (
  set REPOS_USER=%%K
  set REPOS_EMAIL=%%L
 )
)
endlocal & set REPOS_USER=%REPOS_USER%& set REPOS_EMAIL=%REPOS_EMAIL%

if not ""=="%REPOS_USER%" if not ""=="%REPOS_EMAIL%" exit /b 0

set REPOS_USER
set REPOS_EMAIL

echo Username or email empty
exit /b 1

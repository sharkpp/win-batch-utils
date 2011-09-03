@echo off

set git_install_root=C:\msysgit\msysgit\

rem ------------------------------------
rem git コマンドにパスを通す
rem ------------------------------------
:mktmp
set TMP_FILE=%~dp0%RANDOM%.tmp
if exist "%SUB_CMD%" goto :mktmp
setlocal
set ComSpec=/?^>nul ^& set^>"%TMP_FILE%"
call %git_install_root%git-cmd.bat
endlocal
for /F "delims== tokens=1,*" %%I in ('type "%TMP_FILE%"') do set %%I=%%J
del "%TMP_FILE%"
rem ------------------------------------

rem ------------------------------------
rem authorsファイルからユーザー名とメールアドレスを取得
rem ------------------------------------
set REPOS_USER=
set REPOS_EMAIL=
setlocal ENABLEDELAYEDEXPANSION
for /F "tokens=*" %%I in (authors) do (
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

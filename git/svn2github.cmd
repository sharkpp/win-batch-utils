@echo off
setlocal

if "%~2"=="" goto :usage

pushd %~dp0

rem git用に環境を整える
call "%~dp0git_env.cmd"
if errorlevel 1 goto :put_error

set SVN_REPOS=%1
set GIT_PATH=%2

echo ----------------------------------------------
echo USERNAME:  %USERNAME%
echo SVN_REPOS: %SVN_REPOS%
echo GIT_REPOS: git@github.com:%USERNAME%/%GIT_PATH%.git
echo ----------------------------------------------

pause

git svn clone --authors-file="%~dp0authors" --username=%USERNAME% %SVN_REPOS% %GIT_PATH%
cd %GIT_PATH%
cd
git log
git remote add origin git@github.com:%USERNAME%/%GIT_PATH%.git
if errorlevel 1 goto :put_error
git push origin master
if errorlevel 1 goto :put_error
cd ..

goto :eof

:usage
echo svn2github SVN_REPOS GIT_DIR
goto :eof

rem エラーの表示
:put_error
echo result=%ERRORLEVEL%
pause

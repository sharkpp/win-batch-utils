@echo off
setlocal

rem 参考:
rem   http://blog.makotokw.com/memo/github/
rem   http://blog.livedoor.jp/dankogai/archives/51194979.html

if "%~2"=="" goto :usage

rem git用に環境を整える
call "%~dp0git_env.cmd"
if errorlevel 1 goto :put_error

set SVN_REPOS=%1
set GIT_PATH=%2

echo ----------------------------------------------
echo USERNAME:  %REPOS_USER% ^<%REPOS_EMAIL%^>
echo SVN_REPOS: %SVN_REPOS%
echo GIT_REPOS: git@github.com:%REPOS_USER%/%GIT_PATH%.git
echo ----------------------------------------------

git svn clone %3 %4 %5 %6 --authors-file="authors" --username=%REPOS_USER% %SVN_REPOS% %GIT_PATH%
cd %GIT_PATH%
cd
git log
git remote add origin git@github.com:%REPOS_USER%/%GIT_PATH%.git
if errorlevel 1 goto :put_error
git push origin master
if errorlevel 1 goto :put_error
cd ..

goto :eof

:usage
echo usage: svn2github.cmd SVN_REPOS GIT_DIR [GIT_OPTION]
echo   ex.
echo     svn2github.cmd http://svn.example.net/test example-test -s
goto :eof

rem エラーの表示
:put_error
echo result=%ERRORLEVEL%
pause

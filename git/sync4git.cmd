@echo off
setlocal

rem 参考:
rem   http://blog.livedoor.jp/dankogai/archives/51194979.html

set GIT_BASE=%~dp0
if not ""=="%~1" set GIT_BASE=%~1
set GIT_BASE=%GIT_BASE%\
set GIT_BASE=%GIT_BASE:\\=\%

echo git base: %GIT_BASE%
pushd %GIT_BASE%

rem git用に環境を整える
call "%~dp0git_env.cmd"
if errorlevel 1 goto :put_error

for /D %%I in (*) do (
 pushd %%I
 echo updating: %%I
 git svn rebase --authors-file="%GIT_BASE%authors" --username=%REPOS_USER%
 if errorlevel 1 goto :put_error
 popd
)

goto :eof

rem エラーの表示
:put_error
echo result=%ERRORLEVEL%
pause

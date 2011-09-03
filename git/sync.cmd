@echo off
setlocal

pushd "%~dp0"

rem git用に環境を整える
call "%~dp0git_env.cmd"
if errorlevel 1 goto :put_error

for /D %%I in (*) do (
pushd %%I
git svn rebase --authors-file="%~dp0authors" --username=%REPOS_USER%
if errorlevel 1 goto :put_error
popd
)

goto :eof

rem エラーの表示
:put_error
echo result=%ERRORLEVEL%
pause

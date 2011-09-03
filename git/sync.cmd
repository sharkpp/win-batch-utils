@echo off
setlocal

pushd "%~dp0"

rem git�p�Ɋ��𐮂���
call "%~dp0git_env.cmd"
if errorlevel 1 goto :put_error

for /D %%I in (*) do (
pushd %%I
git svn rebase --authors-file="%~dp0authors" --username=%REPOS_USER%
if errorlevel 1 goto :put_error
popd
)

goto :eof

rem �G���[�̕\��
:put_error
echo result=%ERRORLEVEL%
pause

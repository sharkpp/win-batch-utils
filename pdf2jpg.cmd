@echo off
setlocal
path %path%;c:\Program Files (x86)\gs\gs9.00\bin;

mkdir "%~dp1\%~n1"
pushd "%~dp1\%~n1"

gswin32c.exe -dBATCH -dNOPAUSE -sDEVICE=jpeg -r200x200 -sOutputFile="%%03d.jpg" "%~1"
if errorlevel 1 goto :onerr

pushd "%~dp1"

7z a -tzip -mx9 "%~dp1\%~n1.zip" "%~n1"
if errorlevel 1 goto :onerr

goto :eof
:onerr
pause

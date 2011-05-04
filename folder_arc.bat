@echo off
setlocal
rem 7zの実行ファイルフォルダをパスに追加
set SZ_PATH=
for /D %%I in ("%ProgramFiles(x86)%\7-Zip") do set SZ_PATH=%%~I
for /D %%I in ("%ProgramFiles%\7-Zip")      do set SZ_PATH=%%~I
if "%SZ_PATH%"=="" goto :onerr_no_7z

path %path%;%GS_PATH%;%SZ_PATH%

set DEST_DIR=.
if not %1.==. (
	set DEST_DIR=%1
	mkdir %DEST_DIR%>nul
)

for /d %%I in (*) do (
	echo "%%I"
	7z a -tzip -mx9 "%DEST_DIR%\%%I.zip" "%%I"
)

endlocal

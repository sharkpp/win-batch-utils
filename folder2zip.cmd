@echo off
setlocal

rem ******************************************************************
rem 圧縮ファイル形式変換バッチファイル
rem   usage: folder2zip.cmd
rem ※folder2zip.exclude.txt があれば、書かれているファイルを
rem 圧縮処理から除外します
rem ******************************************************************

rem 7zの実行ファイルフォルダをパスに追加
set SZ_PATH=
for /D %%I in ("%ProgramFiles(x86)%\7-Zip") do set SZ_PATH=%%~I
for /D %%I in ("%ProgramFiles%\7-Zip")      do set SZ_PATH=%%~I
if "%SZ_PATH%"=="" goto :onerr_no_7z

path %path%;%GS_PATH%;%SZ_PATH%

set EXCLUDE_LIST=%~dpn0.exclude.txt

set DEST_DIR=.
if not %1.==. (
	set DEST_DIR=%1
	mkdir %DEST_DIR%>nul
)

rem 圧縮用コマンドライン生成
set _=
if exist "%EXCLUDE_LIST%" set _=%_% -x@"%EXCLUDE_LIST%"

rem 圧縮
for /d %%I in (*) do (
	echo "%%I"
	7z a -tzip -mx9 %_% "%DEST_DIR%\%%I.zip" "%%I"
)

endlocal

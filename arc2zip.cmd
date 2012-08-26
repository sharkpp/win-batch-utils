@echo off
setlocal

rem ******************************************************************
rem 圧縮ファイル形式変換バッチファイル
rem   usage: arc2zip.cmd [TARGET_FOLDER ...]
rem ※arc2zip.exclude.txt があれば、書かれているファイルを
rem 圧縮処理から除外します
rem ******************************************************************

rem 引数が指定されている場合は引数を順に処理する
if not "" == "%~1" goto :parse_args

rem 7zの実行ファイルフォルダをパスに追加
set SZ_PATH=
for /D %%I in ("%ProgramFiles(x86)%\7-Zip") do set SZ_PATH=%%~I
for /D %%I in ("%ProgramFiles%\7-Zip")      do set SZ_PATH=%%~I
if "%SZ_PATH%"=="" goto :onerr_no_7z

path %path%;%GS_PATH%;%SZ_PATH%

set WORK_DIR=%TEMP%\arc2zip%RANDOM%
set EXCLUDE_LIST=%~dpn0.exclude.txt

set DEST_DIR=.
if not %1.==. (
	set DEST_DIR=%1
	mkdir %DEST_DIR%>nul 2>&1
)

rem 再圧縮処理
for %%I in (*.rar *.cab *.lzh) do call :arc2zip "%%I"

rmdir /S /Q "%WORK_DIR%">nul 2>&1
endlocal
goto :eof

:arc2zip
	echo "%~1"
	rem 作業フォルダ生成
	rmdir /S /Q "%WORK_DIR%">nul 2>&1
	mkdir "%WORK_DIR%">nul 2>&1
	rem 展開
	7z x -o"%WORK_DIR%" "%~1"
	if errorlevel 1 exit /b
	rem 圧縮用コマンドライン生成
	set _=
	if exist "%EXCLUDE_LIST%" set _=%_% -x@"%EXCLUDE_LIST%"
	if exist "%DEST_DIR%\%~n1.zip" (
		set _=%_% "%DEST_DIR%\%~n1_%RANDOM%.zip"
	) else (
		set _=%_% "%DEST_DIR%\%~n1.zip"
	)
	rem 圧縮
	7z a -tzip -mx9 -r %_% "%WORK_DIR%\*"
	exit /b

rem 引数処理
:parse_args
	set _0="%~dpnx0"
:parse_args_core
	pushd "%~1"
	call %_0%
	popd
	shift
	if not "" == "%~1" goto :parse_args_core
	endlocal
	goto :eof


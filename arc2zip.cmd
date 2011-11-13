@echo off
setlocal

rem ******************************************************************
rem ���k�t�@�C���`���ϊ��o�b�`�t�@�C��
rem   usage: arc2zip.cmd
rem ��arc2zip.exclude.txt ������΁A������Ă���t�@�C����
rem ���k�������珜�O���܂�
rem ******************************************************************

rem 7z�̎��s�t�@�C���t�H���_���p�X�ɒǉ�
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

rem �Ĉ��k����
for %%I in (*.rar *.cab *.lzh) do call :arc2zip "%%I"

rmdir /S /Q "%WORK_DIR%">nul 2>&1
endlocal
goto :eof

:arc2zip
	echo "%~1"
	rem ��ƃt�H���_����
	rmdir /S /Q "%WORK_DIR%">nul 2>&1
	mkdir "%WORK_DIR%">nul 2>&1
	rem �W�J
	7z x -o"%WORK_DIR%" "%~1"
	if errorlevel 1 exit /b
	rem ���k�p�R�}���h���C������
	set _=
	if exist "%EXCLUDE_LIST%" set _=%_% -x@"%EXCLUDE_LIST%"
	if exist "%DEST_DIR%\%~n1.zip" (
		set _=%_% "%DEST_DIR%\%~n1_%RANDOM%.zip"
	) else (
		set _=%_% "%DEST_DIR%\%~n1.zip"
	)
	rem ���k
	7z a -tzip -mx9 -r %_% "%WORK_DIR%\*"
	exit /b

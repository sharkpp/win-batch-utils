@echo off
setlocal
rem GhostScript�̎��s�t�@�C���t�H���_���p�X�ɒǉ�
set GS_PATH=
for /D %%I in ("%ProgramFiles(x86)%\gs"\*) do for /D %%J in ("%%I\bin") do set GS_PATH=%%~J
for /D %%I in ("%ProgramFiles%\gs"\*)      do for /D %%J in ("%%I\bin") do set GS_PATH=%%~J
if "%GS_PATH%"=="" goto :onerr_no_gs
rem 7z�̎��s�t�@�C���t�H���_���p�X�ɒǉ�
set SZ_PATH=
for /D %%I in ("%ProgramFiles(x86)%\7-Zip") do set SZ_PATH=%%~I
for /D %%I in ("%ProgramFiles%\7-Zip")      do set SZ_PATH=%%~I
if "%SZ_PATH%"=="" goto :onerr_no_7z

path %path%;%GS_PATH%;%SZ_PATH%

rem gswin32c.exe --help

rem ���k��t�H���_���폜���邩�H
set _DELETE_AFTER_ZIPPED=
rem jpeg�ւ̕ϊ��̂�
set _JPEG_CONVERT_ONLY=
rem pixels/inch resolution for gs
set _PIXEL_PER_INCH=200
rem �o�͐�t�H���_�p�X
set _OUTPUT_PATH=
rem pdf�����k����
set _WITH_PDF_ZIPPING=

:option_read
  set _=%~1
  if "%_:~0,1%"=="-" (
    if /I "%_:~1%"=="d" (
      set _DELETE_AFTER_ZIPPED=1
      shift & goto :option_read
    )
    if /I "%_:~1%"=="j" (
      set _JPEG_CONVERT_ONLY=1
      shift & goto :option_read
    )
    if /I "%_:~1%"=="w" (
      set _WITH_PDF_ZIPPING=1
      shift & goto :option_read
    )
    if /I "%_:~1%"=="r" (
      shift
      if not "%~2"=="" set _PIXEL_PER_INCH=%2
      shift & goto :option_read
    )
    if /I "%_:~1%"=="o" (
      shift
      if not "%~2"=="" set _OUTPUT_PATH="%~f2"
      shift & goto :option_read
    )
    echo �s���ȃI�v�V����: "%_%"
    goto :usage
  )

if "%~1"=="" goto :usage

:convert_loop
  for %%I in ("%~1") do (
    echo �ϊ���... %%I
    call :convert "%%~fI"
    rem if errorlevel 1 goto :eof
  )
  shift
  if not "%~1"=="" goto :convert_loop

goto :eof

rem �ϊ�����
:convert

 if not "%_OUTPUT_PATH%"=="" (
  pushd "%_OUTPUT_PATH%"
 ) else (
  pushd "%~dp1"
 )
 if errorlevel 1 exit /b

 mkdir "%~n1"
 if errorlevel 1 exit /b

 cd "%~n1"

 gswin32c.exe -dBATCH -dNOPAUSE -sDEVICE=jpeg -r%_PIXEL_PER_INCH% -sOutputFile="%%03d.jpg" "%~1"
 if errorlevel 1 exit /b

 if not "%_JPEG_CONVERT_ONLY%"=="" (
  popd
  exit /b 0
 )

 cd ..

 if not "%_WITH_PDF_ZIPPING%"=="" (
  mkdir "%~n1\pdf"
  copy "%~1" "%~n1\pdf"
 )

 7z a -tzip -mx9 "%~n1.zip" "%~n1"
 if errorlevel 1 exit /b

 if not "%_DELETE_AFTER_ZIPPED%"=="" rmdir /S /Q "%~n1"

 popd

 exit /b 0

:onerr_no_gs
 echo Ghost Script ���C���X�g�[������Ă��܂���
 goto :onerr

:onerr_no_7z
 echo 7-zip ���C���X�g�[������Ă��܂���
 goto :onerr

:usage
 echo pdf to jpg and zip converter
 echo usage: pdf2jpg.cmd [OPTION] FILE [FILE2 ...]
 echo OPTION:
 echo  -o PATH
 echo    �o�͐�t�H���_�p�X
 echo  -d
 echo    ���k��Ƀt�H���_���폜����
 echo  -j
 echo    jpeg�ւ̕ϊ��̂�
 echo  -w
 echo    pdf�����k����
 echo  -r RESOLUTION
 echo    �摜�̃s�N�Z��/�C���`�𑜓x�A�����l��200
 goto :onerr

:onerr
 pause

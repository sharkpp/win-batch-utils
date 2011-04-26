@echo off
setlocal
path %path%;c:\program files\7-zip

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

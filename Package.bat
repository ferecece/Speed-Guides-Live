@echo off

if [%1]==[] goto usage

set OUT_DIR=.\unofficial_builds\%1
mkdir %OUT_DIR%

REM copy relevant files to proper directory
xcopy src\LiveSplit %OUT_DIR%\LiveSplit /S /Y /I
xcopy .\README.md %OUT_DIR% /Y
echo F|xcopy .\LICENSE %OUT_DIR%\LICENSE_SGL.txt /Y
echo F|xcopy src\ext\markdig\license.txt %OUT_DIR%\LICENSE_Markdig.txt /Y

set ZIP_NAME=SpeedGuidesLiveUnofficial_%1.zip
echo Creating %ZIP_NAME% ...

REM Create the zip file using PowerShell
powershell Compress-Archive -Path "%OUT_DIR%\*" -DestinationPath "%OUT_DIR%\%ZIP_NAME%" -Force

REM Delete the files after zipping
echo Cleaning up...
rmdir /S /Q "%OUT_DIR%\LiveSplit"
del /Q "%OUT_DIR%\README.md"
del /Q "%OUT_DIR%\LICENSE_SGL.txt"
del /Q "%OUT_DIR%\LICENSE_Markdig.txt"

goto end

:usage
echo Package.bat VERSION
pause

:end

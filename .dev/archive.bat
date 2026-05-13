@echo off
setlocal enabledelayedexpansion

:: Get current directory name for zip file
for %%I in (.) do set "DIRNAME=%%~nxI"

:: Create zip file name with timestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

set "ZIPNAME=%DIRNAME%_%datestamp%.zip"

echo Creating archive: %ZIPNAME%
echo Excluding: .dart_tool, .git, build directories

:: Use PowerShell to create zip with exclusions
powershell -Command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; $source = Get-Location; $destination = Join-Path $source '%ZIPNAME%'; $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal; $includeBaseDirectory = $false; $files = Get-ChildItem -Path $source -Recurse | Where-Object {$_.FullName -notmatch '\\\.dart_tool\\|\\\.git\\|\\build\\'}; $zip = [System.IO.Compression.ZipFile]::Open($destination, 'Create'); foreach($file in $files) {if(-not $file.PSIsContainer) {$relativePath = $file.FullName.Substring($source.Path.Length + 1); [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $relativePath, $compressionLevel) | Out-Null}}; $zip.Dispose()}"

if exist "%ZIPNAME%" (
    echo.
    echo Archive created successfully: %ZIPNAME%
    for %%A in ("%ZIPNAME%") do echo File size: %%~zA bytes
) else (
    echo.
    echo Error: Failed to create archive
    exit /b 1
)

pause
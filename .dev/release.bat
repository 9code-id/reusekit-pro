set sourceDir=C:\Users\Administrator\Desktop\reusekit_codespace
set targetDir=C:\Users\Administrator\Desktop\reusekit_codes\%1

xcopy "%sourceDir%\.dev" "%targetDir%\.dev" /E/H/C/I/Y
xcopy "%sourceDir%\.devcontainer" "%targetDir%\.devcontainer" /E/H/C/I/Y

xcopy "%sourceDir%\lib" "%targetDir%\lib" /E/H/C/I/Y
xcopy "%sourceDir%\android" "%targetDir%\android" /E/H/C/I/Y
xcopy "%sourceDir%\web" "%targetDir%\web" /E/H/C/I/Y
xcopy "%sourceDir%\ios" "%targetDir%\ios" /E/H/C/I/Y
xcopy "%sourceDir%\assets" "%targetDir%\assets" /E/H/C/I/Y
xcopy "%sourceDir%\.github" "%targetDir%\.github" /E/H/C/I/Y
xcopy "%sourceDir%\test" "%targetDir%\test" /E/H/C/I/Y

copy "%sourceDir%\LICENSE" "%targetDir%\LICENSE" /Y
copy "%sourceDir%\pubspec.yaml" "%targetDir%\pubspec.yaml" /Y
copy "%sourceDir%\analysis_options.yaml" "%targetDir%\analysis_options.yaml" /Y
copy "%sourceDir%\l10n.yaml" "%targetDir%\l10n.yaml" /Y
copy "%sourceDir%\README.md" "%targetDir%\README.md" /Y
copy "%sourceDir%\docs.html" "%targetDir%\docs.html" /Y
copy "%sourceDir%\views.json" "%targetDir%\views.json" /Y
copy "%sourceDir%\dev.bat" "%targetDir%\dev.bat" /Y

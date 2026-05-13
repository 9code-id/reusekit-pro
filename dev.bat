@echo off

:start
echo.
echo ================================
echo    Development Menu
echo ================================
echo.
echo Please choose an option (1-5):
echo.
echo 1. Run Checker 
echo 2. Check unfinished views
echo 3. Refresh lib/views.dart
echo 4. Check with Analyzer
echo 5. Delete all with soft Analyzer
echo 6. Delete all with hard Analyzer
echo 7. Delete all view with ui errors
echo 8. Release build commands
echo 9. Update landing pages
echo 10. Create zip file
echo r. run in web-server:3000
echo (ctrl+c, y) to exit
echo.

if "%1" neq "" (
    set choice=%1
) else (
    set /p choice="Enter your choice: "
)

if "%choice%"=="1" goto option1
if "%choice%"=="2" goto option2
if "%choice%"=="3" goto option3
if "%choice%"=="4" goto option4
if "%choice%"=="5" goto option5
if "%choice%"=="6" goto option6
if "%choice%"=="7" goto option7
if "%choice%"=="8" goto option8
if "%choice%"=="9" goto option9
if "%choice%"=="10" goto option10
if "%choice%"=="r" goto optionRun
goto invalid

:option1
dart .dev\check_widget_restriction.dart && code .dev\\log\\errors.json
goto end

:option2
dart .dev\check_unfinished_views.dart && code views_progress.json
goto end

:option3
dart .dev\delete_error_files.dart && dart .dev\generate_view.dart && dart .dev\unused_file_remover.dart && dart .dev\core_update.dart
goto end

:option4
dart .dev\check_with_analyzer.dart && .dev\\log\\analyzed.txt
goto end

:option5
dart .dev\delete_all_with_soft_analyzer.dart && .dev\\log\\analyzed.txt
goto end

:option6
dart .dev\delete_all_with_analyzer.dart && .dev\log\analyzed.txt
goto end

:option7
dart .dev\delete_error_ui_files.dart
goto end

:option8
dart .dev\release_build_commands.dart && commands.bat && dart .dev\release_update_views.dart && commands2.bat
goto end

:option9
xcopy .\lib\presentation\* C:\Users\Administrator\Desktop\reusekit_codes\public\codes\ /E /I /Y && ^
powershell -Command "Get-ChildItem -Path 'C:\Users\Administrator\Desktop\reusekit_codes\public\codes\' -File | ForEach-Object { Rename-Item -Path $_.FullName -NewName ($_.BaseName + '.txt') }"
goto end

:option10
commands3.bat
goto end

:optionRun
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 3000
goto end

:invalid
echo Invalid choice. Please select 1-5.
goto start

:end
pause
Execute batch view generation:

1. Run: cd %cd% && dart .dev\read_view_progress.dart {batch_number} && timeout /t 10 >nul && exit
2. Create exactly 10 Views from the console output (no more, no less)
3. Overwrite existing files without checking if they exist
4. Only create the 10 requested views - no other files
5. Only run the command from step 1 - no other console commands
6. No review, confirmation, or additional actions after completion

Stop immediately after creating the 10 views.   
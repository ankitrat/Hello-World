@echo "hello"
setlocal


:: Launch one and two asynchronously, with stream 9 redirected to a lock file.
:: The lock file will remain locked until the script ends.
start "" cmd /c 9>"%lock%1" db.bat
start "" cmd /c 9>"%lock%2" web.bat

:Wait for both scripts to finish (wait until lock files are no longer locked)
1>nul 2>nul ping /n 2 ::1
for %%N in (1 2) do (
  ( rem
  ) 9>"%lock%%%N" || goto :Wait
) 2>nul

:: Launch three and four asynchronously
call test1.bat
call test2.bat
pause

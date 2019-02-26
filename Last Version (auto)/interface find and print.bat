@echo off
(for /f "tokens=3* delims= " %%a in ('netsh Interface show interface ^|find /I "Connected"') do echo %%b) > interfaces.txt
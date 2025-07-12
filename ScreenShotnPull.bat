@echo off


set FILENAME=%DATE:/=-%@%TIME::=-%
set FILENAME=%FILENAME: =%
set FILENAME=%FILENAME:,=.%.png

adb shell screencap -p /sdcard/screen.png

adb pull /sdcard/screen.png ./%FILENAME%

REM Delete /sdcard/screen.png
adb shell rm /sdcard/screen.png

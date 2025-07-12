@echo off
:: =================================================================
:: Android Screen Recorder with Diagnostic Logging (v2 - Fixed)
:: =================================================================
:: This script records the screen of a connected Android device.
:: It provides step-by-step logs to help diagnose any issues.
::
:: FIX: This version launches the recording in a separate window
:: to prevent CTRL+C from closing the entire script.
:: =================================================================

:: --- STEP 1: SETUP AND INITIAL CHECKS ---
echo [LOG] Script started. Setting up filename...
set FILENAME=%DATE:/=-%@%TIME::=-%
set FILENAME=%FILENAME: =%
set FILENAME=%FILENAME:,=.%.mp4
echo [LOG] Filename will be: %FILENAME%
echo.

echo [LOG] Checking for connected and authorized devices...
adb devices
echo.
echo [INFO] Please check the list above. If your device shows as "unauthorized",
echo [INFO] please unplug it, plug it back in, and accept the "Allow USB debugging"
echo [INFO] prompt on your device screen.
echo [INFO] If no device is listed, ensure it's connected and in "File Transfer" mode.
echo.
pause

:: --- STEP 2: START RECORDING ---
echo [LOG] Attempting to start screen recording in a new window...
echo [INFO] The recording will start in a new, separate window.
echo [INFO] To stop the recording, simply return to THIS window and press any key.

:: Use 'start' to run the recording in a non-blocking way.
start "Screen-Recording" adb shell screenrecord --bugreport /sdcard/rec.mp4

echo.
echo =======================================================
echo    RECORDING IS ACTIVE IN ANOTHER WINDOW
echo.
echo    PRESS ANY KEY IN THIS WINDOW TO STOP & SAVE...
echo =======================================================
pause >nul

:: --- STEP 3: STOP RECORDING AND PULL THE FILE ---
echo.
echo [LOG] Stop signal received. Terminating the recording process...
:: Kill the adb process to stop the screenrecord command.
taskkill /IM adb.exe /F >nul
echo [LOG] Recording process terminated.

:: A short delay to ensure the file is finalized on the device.
echo [LOG] Waiting 2 seconds for video file to finalize...
timeout /t 2 /nobreak >nul

echo.
echo [LOG] Attempting to pull /sdcard/rec.mp4 from the device...
adb pull /sdcard/rec.mp4 ./%FILENAME%

:: Check if the pull command failed.
if %errorlevel% neq 0 (
    echo [ERROR] Failed to pull the video file from the device.
    echo [ERROR] This usually means the recording failed to save correctly.
    goto end
)
echo [LOG] Pull command executed.

:: Verify that the file actually exists on the computer now.
if not exist .\%FILENAME% (
    echo [ERROR] File was not found on the computer after pulling!
    echo [ERROR] The recording likely failed to create a valid video file.
    goto end
)
echo [SUCCESS] Video file successfully saved as %FILENAME%
echo.

:: --- STEP 4: CLEANUP ---
echo [LOG] Attempting to delete temporary file /sdcard/rec.mp4 from device...
adb shell rm /sdcard/rec.mp4
echo [LOG] Cleanup command sent.

:end
echo.
echo [INFO] Script finished.
pause

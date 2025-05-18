@echo off
title Windows Defender Devre Dışı Bırakıcı - SkyTeam Edition
color 0A
cls

:: ASCII sanat başlık
echo   ___ _  ____   _____ ___  _    ___  
echo  / __| |/ /\ \ / / __/ _ \| |  |   \ 
echo  \__ \ ' <  \ V / (_| (_) | |__| |) |
echo  |___/_|\_\  |_| \___\___/|____|___/ 
echo.

timeout /t 2 >nul

:: Yönetici kontrolü
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo [!] Lütfen scripti YÖNETİCİ olarak çalıştırın!
    pause
    exit /b
)

echo [*] Defender ayarları yapılıyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] PowerShell üzerinden korumalar devre dışı bırakılıyor...
powershell -Command "try {
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction Stop
    Set-MpPreference -DisableIOAVProtection $true
    Set-MpPreference -DisableScriptScanning $true
    Set-MpPreference -SubmitSamplesConsent 2
    Write-Host '[✓] PowerShell ayarları başarıyla uygulandı.' -ForegroundColor Green
} catch {
    Write-Host '[!] Hata: Yönetici olarak çalıştırdığınızdan emin olun.' -ForegroundColor Red
    exit 1
}"

echo.
echo =============================================
echo [✓] İşlem tamamlandı!       -- SkyTeam --
echo [!] Lütfen bilgisayarı yeniden başlatın.
echo =============================================

pause

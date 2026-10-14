@echo off
setlocal
title Florist POS - Setup va chay

cd /d "%~dp0"

echo ==========================================
echo   FLORIST POS - CAI MOI TRUONG VA CHAY
echo ==========================================
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo [LOI] Chua tim thay Node.js.
  echo Hay cai Node.js ban LTS tu https://nodejs.org/
  echo Sau khi cai xong, dong cua so nay va chay lai run-pos.bat.
  pause
  exit /b 1
)

where npm >nul 2>nul
if errorlevel 1 (
  echo [LOI] Chua tim thay npm. Hay cai lai Node.js ban LTS.
  pause
  exit /b 1
)

echo Node.js:
node --version
echo npm:
npm --version
echo.

if not exist "frontend\package.json" (
  echo [LOI] Khong tim thay frontend\package.json.
  echo Hay giai nen day du thu muc florist-pos.
  pause
  exit /b 1
)

cd /d "%~dp0frontend"

if not exist "node_modules" (
  echo Dang tai cac thu vien frontend. Can ket noi Internet...
  call npm install
  if errorlevel 1 (
    echo.
    echo [LOI] npm install that bai. Kiem tra Internet, proxy hoac loi npm.
    pause
    exit /b 1
  )
)

echo.
echo Dang khoi dong Florist POS...
echo Khi Vite hien URL, mo dia chi do tren trinh duyet.
echo Thuong la http://localhost:5173
echo Nhan Ctrl+C de dung.
echo.
call npm run dev
pause

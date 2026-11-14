@echo off
rem Double-click to publish .\site to Cloudflare Pages (Windows).
set PROJECT=dead-reckoning
cd /d "%~dp0"
where npx >nul 2>nul || (echo Node.js is required. Install it from https://nodejs.org then double-click again. & pause & exit /b 1)
call npx --yes wrangler whoami 2>&1 | findstr /i "not authenticated" >nul && (
  echo First run: log into Cloudflare in the browser window that opens...
  call npx --yes wrangler login
)
call npx --yes wrangler pages project create %PROJECT% --production-branch main >nul 2>nul
echo Publishing .\site to %PROJECT% ...
call npx --yes wrangler pages deploy site --project-name %PROJECT% --branch main --commit-dirty=true && echo. && echo Live at https://%PROJECT%.pages.dev
pause

#!/bin/bash
# Double-click to publish ./site to Cloudflare Pages (macOS).
PROJECT="dead-reckoning"   # becomes https://dead-reckoning.pages.dev
cd "$(dirname "$0")" || exit 1
pause(){ read -n1 -r -p "Press any key to close..."; echo; }
if ! command -v npx >/dev/null 2>&1; then
  echo "Node.js is required. Install it from https://nodejs.org then double-click again."; pause; exit 1
fi
W="npx --yes wrangler"
if $W whoami 2>&1 | grep -qi "not authenticated"; then
  echo "First run: log into Cloudflare in the browser window that opens..."; $W login || { pause; exit 1; }
fi
$W pages project create "$PROJECT" --production-branch main >/dev/null 2>&1 || true
echo "Publishing ./site to $PROJECT ..."
if $W pages deploy site --project-name "$PROJECT" --branch main --commit-dirty=true; then
  echo; echo "Live at https://$PROJECT.pages.dev"
else
  echo; echo "Deploy failed - see the message above."
fi
pause

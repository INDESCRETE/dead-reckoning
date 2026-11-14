#!/bin/bash
# Double-click to save this folder to GitHub (macOS).
# First run creates a private repo called $REPO on your account; later runs push changes.
REPO="dead-reckoning"
cd "$(dirname "$0")" || exit 1
pause(){ read -n1 -r -p "Press any key to close..."; echo; }
if ! command -v git >/dev/null 2>&1; then echo "git is required: run  xcode-select --install  in Terminal, then try again."; pause; exit 1; fi
if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI is required. Install it with:  brew install gh   (or from https://cli.github.com)"; pause; exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "First run: log into GitHub in the browser window that opens..."
  gh auth login --hostname github.com --git-protocol https --web || { pause; exit 1; }
fi
gh auth setup-git >/dev/null 2>&1
if [ ! -d .git ]; then
  git init -q -b main
  LOGIN=$(gh api user -q .login)
  git config user.name  "$(git config --global user.name  || echo "$LOGIN")"
  git config user.email "$(git config --global user.email || echo "$LOGIN@users.noreply.github.com")"
fi
git add -A
git commit -q -m "Update $(date '+%Y-%m-%d %H:%M')" && echo "Saved changes." || echo "No new changes to save."
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Creating private repo '$REPO' on GitHub..."
  gh repo create "$REPO" --private --source=. --remote=origin --push || { pause; exit 1; }
else
  git push -u origin main || { echo "Push failed - see the message above."; pause; exit 1; }
fi
echo; echo "On GitHub: $(gh repo view --json url -q .url 2>/dev/null)"
pause

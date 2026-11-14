# Dead Reckoning

A grainy, retro first-person browser game. Walk narrow cliff ridges in total darkness, ping sonar to see,
and reach the beacon before the thing hunting you by sound finds you. Same maze for everyone each day.

- `site/index.html` is the whole game (single file, no build step)
- `deploy.command` / `deploy.bat` publish `site/` to Cloudflare Pages (dead-reckoning.pages.dev)
- `push-to-github.command` saves this folder to GitHub

Tuning lives in the `CFG` block at the top of `site/index.html`.

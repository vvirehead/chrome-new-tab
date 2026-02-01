# Safe New Tab with custom background

A minimal Chrome extension that replaces the New Tab page with:

- a random custom wallpaper (local files)
- a translucent search bar that turns solid white on focus / when text is entered

No tracking. No permissions. No remote scripts.

## Why this exists

I liked using custom wallpapers for new tab from Chrome market extension, but wanted a safer, minimal replacement:

- uses **local images** (no network calls during normal use)
- no access to browsing data
- works as an unpacked extension

## Project structure

```
.
├─ manifest.json
├─ newtab.html
├─ newtab.css
├─ newtab.js
├─ updateimages.ps1
├─ images.json        # generated (ignored by git)
└─ images/            # downloaded wallpapers (ignored by git)
```

## Setup

### 1) Download wallpapers (one-time)

Download desired wallpapers and put them inside the `images/` folder.

### 2) Generate `images.json`

`images.json` is just a list of filenames from `images/`. Run:

```powershell
.\updateimages.ps1
```

If PowerShell blocks scripts:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Or run once without changing policy:

```powershell
powershell -ExecutionPolicy Bypass -File .\updateimages.ps1
```

### 3) Load unpacked in Chrome

1. Open `chrome://extensions`
2. Enable **Developer mode**
3. Click **Load unpacked**
4. Select the repository root folder (where `manifest.json` is)

Open a new tab (`Ctrl+T`) to verify.

## Updating wallpapers

1. Add/remove files in `images/`
2. Re-run:

```powershell
.\updateimages.ps1
```

3. (Recommended) In `chrome://extensions`, click **Reload** on the extension

## Git / repo hygiene

`images/` and `images.json` are intentionally ignored:

```gitignore
images.json
images/
```

## Security notes

- The extension uses **no permissions**
- All JS/CSS is local (no remote code execution)
- Wallpapers are loaded from local files after the initial download
- Search uses standard Google query submission

## License (MIT)

MIT License

Copyright (c) 2026 vvirehead
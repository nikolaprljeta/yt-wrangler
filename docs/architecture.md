# YouTube Wrangler – Architecture Overview

This document explains the workflow and architecture of YouTube Wrangler.

## 1. Input

- Text is pasted by the user or read from `urls.txt`
- URLs are extracted using a regular expression

## 2. Interactive Video Selection

- The script fetches video titles via `yt-dlp --get-title`
- **Interactive Selection Interface** presents videos in a navigable list
- Users navigate with ↑/↓ arrow keys
- Users toggle selections with SPACEBAR (all pre-selected by default)
- Visual indicators show current position (`>`) and selection status (`[x]`/`[ ]`)
- Real-time counter displays `Selected: X/Y videos`
- Users confirm with ENTER or cancel with ESC/q

## 3. System Checks

- **Internet connectivity**
- **Writable folder**
- **Python 3 availability**
- **OS detection**
- **Disk space check**

## 4. Package Installation

- Installs or updates `yt-dlp` and `ffmpeg`
- Uses **Homebrew** on macOS or `apt`, `dnf`, `pacman` on Linux
- Falls back to `pip3 install --user`

## 5. Download Loop

Downloads each URL with `yt-dlp` using:

- **Best video + audio** quality
- **Timeout** per video
- **Resume support**
- **Logging**
- Completed URLs are commented out in `urls.txt`

## 6. Retry Loop

- Failed URLs are retried up to `MAX_RETRIES`

## 7. Logging & Completion

- Logs all downloads to `download.log`
- Provides a summary message when finished
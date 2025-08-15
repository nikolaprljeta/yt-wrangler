# Changelog

All notable changes to **YouTube Wrangler** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-08-14

### Added
- Initial release of YouTube Wrangler
- Interactive URL input: paste text or use `urls.txt`
- Video title confirmation before download
- Automatic installation and update of `yt-dlp` and `ffmpeg`
- Cross-platform support (macOS, Linux, Windows/WSL)
- Resumable downloads with retry functionality
- Per-video timeout and disk space warnings
- Comprehensive logging in `download.log`
- Graceful exit handling on user interruption (Ctrl+C)
- URL extraction from any text input using regex
- Package manager integration (Homebrew, apt, dnf, pacman)
- Fallback to pip installation when package managers unavailable
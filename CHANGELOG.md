# Changelog

All notable changes to **YouTube Wrangler** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2025-08-15

### Added
- **🎯 Interactive Video Selection Interface**: Complete overhaul of the video confirmation process
  - Navigate through video list with ↑/↓ arrow keys
  - Toggle individual video selections with SPACEBAR
  - Visual indicators: `>` for current position, `[x]` for selected, `[ ]` for unselected
  - Real-time selection counter showing `Selected: X/Y videos`
  - All videos pre-selected by default for convenience
- **Enhanced User Experience**:
  - Clear visual feedback during navigation
  - ESC/q keys for quick cancellation
  - ENTER to confirm selection and proceed
  - Final selection summary before download begins
- **Selective Downloading**: Only downloads user-selected videos, skipping unselected ones

### Changed
- Replaced simple y/N confirmation with advanced interactive selection interface
- Updated welcome text and help messages to reflect new capabilities
- Enhanced error handling for the new interactive features

### Technical Details
- Added `interactive_url_selection()` function with full keyboard navigation
- Implemented real-time screen updates and cursor management
- Maintained backward compatibility with existing URL processing logic

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
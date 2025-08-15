# YouTube Wrangler – Usage Example

This guide shows how to use YouTube Wrangler to download YouTube videos.

## 1. Prepare the Script

Make sure the script is executable:

```bash
chmod +x youtube-wrangler.sh
```

Ensure Python 3 is installed:

```bash
python3 --version
```

## 2. Launch the Script

Run:

```bash
./youtube-wrangler.sh
```

## 3. Interactive Options

On launch, choose one of the following:

1. **Paste text manually** – any text containing YouTube URLs
2. **Use text from urls.txt** – load URLs from the file
3. **Quit** – exit the script

## 4. Interactive Video Selection

The script will extract URLs and fetch video titles, then present the **Interactive Selection Interface**:

```
==============================
 Select Videos to Download
==============================
Use ↑/↓ to navigate, SPACE to toggle selection, ENTER to confirm, ESC/q to quit
Selected videos are marked with [x]

> [x] Rick Astley - Never Gonna Give You Up
  [x] Me at the zoo
  [x] Charlie bit my finger - again !

Selected: 3/3 videos
```

### Navigation Controls:
- **↑/↓ Arrow Keys**: Move between videos
- **SPACEBAR**: Toggle selection (uncheck videos you don't want)
- **ENTER**: Confirm selection and start download
- **ESC/q**: Cancel and exit

### Visual Indicators:
- `>` shows your current position
- `[x]` means video is selected for download
- `[ ]` means video will be skipped
- All videos are selected by default

After pressing ENTER, you'll see a final confirmation:

```
Selected videos for download:
✓ Rick Astley - Never Gonna Give You Up
✓ Me at the zoo
```

## 5. Download

The script will download the videos, log progress in `download.log`, and retry failed downloads up to the maximum retry count.
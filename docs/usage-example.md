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

## 4. Confirm URLs

The script will extract URLs and fetch video titles for confirmation:

```
- Rick Astley - Never Gonna Give You Up
  https://youtu.be/dQw4w9WgXcQ?si=j7lDjynbQnziQi7t
```

Confirm to proceed.

## 5. Download

The script will download the videos, log progress in `download.log`, and retry failed downloads up to the maximum retry count.
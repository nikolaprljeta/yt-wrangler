# 📺 YouTube Wrangler

YouTube Wrangler is a fault-tolerant, interactive YouTube downloader with **advanced selection interface** that makes grabbing videos easy and safe.

## ⚡ Features

- **🎯 Interactive Video Selection**: Navigate with arrow keys, toggle selections with spacebar
- **✅ Smart Defaults**: All videos pre-selected, just uncheck what you don't want
- **📋 Visual Selection Interface**: See titles, selection status, and current position at a glance
- **Cross-platform**: macOS, Linux, Windows/WSL
- **Automatic yt-dlp & ffmpeg install/update**
- **Python 3 check** with interactive install
- **Resumable downloads** with retries & per-video timeout
- **Logging and URL commenting**
- **Disk space warning**
- **Graceful exit** on interruption
- **Smart URL extraction**: automatically finds YouTube links in any text or file
- **Retry loop** for failed URLs

## 🛠️ Installation

1. Ensure you have **Python 3** installed.
2. Ensure **ffmpeg** and **yt-dlp** are installed, or let the script install/update them.
3. Clone or download this repository:

```bash
git clone https://github.com/nikolaprljeta/yt-wrangler.git
cd yt-wrangler
```

4. Make the script executable (Unix systems):

```bash
chmod +x yt-wrangler.sh
```

## 🚀 Usage

Run the script:

```bash
./yt-wrangler.sh
```

Choose an option:

- **Paste text manually** – Enter any text (emails, messages, articles, etc.) and the script will automatically extract YouTube URLs from the mixed content
- **Use text from urls.txt** – Load any text file containing YouTube links mixed with other content
- **Quit** – Exit the script

After choosing an option, you'll enter the **Interactive Selection Interface**:

### 🎮 Interactive Selection Controls

- **↑/↓ Arrow Keys**: Navigate through the video list
- **SPACEBAR**: Toggle selection for the current video
- **ENTER**: Confirm selection and start downloading
- **ESC/q**: Cancel and exit

**Visual Indicators:**
- `>` Current video position
- `[x]` Selected videos (downloaded by default)
- `[ ]` Unselected videos (will be skipped)
- Counter shows `Selected: X/Y videos`

Progress and errors are logged in `download.log`.

📖 **[Read the Complete Interactive Selection Guide →](docs/interactive-selection-guide.md)**

## ⚙️ Configuration / Examples

- **Text input** can include any kind of mixed content - emails, chat logs, articles, documents - the script intelligently extracts only YouTube URLs
- **`urls.txt`** can contain mixed text content or clean URLs. YouTube links will be extracted automatically. Already-downloaded URLs will be commented out automatically
- **Disk space warning** triggers if less than 2 GB is free
- **Downloads are resumable**; failed or timed-out downloads remain in `urls.txt` for retrying

## 📝 Contributing

Feel free to fork, submit issues, or make pull requests. Follow coding conventions and update the README accordingly.

## ⚖️ License

This project is licensed under the [MIT License](LICENSE).

## ⚠️ Disclaimer

**Important**: Downloading copyrighted content without permission may violate copyright laws. You are responsible for ensuring that all downloads comply with applicable laws in your jurisdiction. This script is intended for downloading content that you own or have permission to use. The author is not liable for any illegal usage of this tool.
#!/bin/bash

# ============================
# YouTube Wrangler – Fault-Tolerant Interactive YouTube Downloader
# ============================

URL_FILE="urls.txt"
LOG_FILE="download.log"
PER_VIDEO_TIMEOUT=3600
MAX_RETRIES=2

# --- Graceful exit ---
trap "echo '⚠️ Interrupted by user. Exiting...'; exit 1" SIGINT

# --- Functions ---
extract_urls() {
    grep -Eo 'https?://[^\s]+' <<< "$1" | sort -u
}

show_urls_with_names() {
    echo "Fetching video titles..."
    urls=("$@")
    for url in "${urls[@]}"; do
        title=$(yt-dlp --get-title "$url" 2>/dev/null)
        echo "- $title"
        echo "  $url"
    done
}

check_dependency_mac() {
    local pkg="$1"
    local emoji="$2"
    if ! command -v "$pkg" &>/dev/null; then
        echo "$emoji Checking $pkg... Not installed"
        read -p "Install $pkg now? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            brew install "$pkg"
        else
            echo "$pkg is required. Exiting."
            exit 1
        fi
    else
        # Check version with brew
        local outdated
        outdated=$(brew outdated --quiet "$pkg")
        if [[ -n "$outdated" ]]; then
            echo "$emoji Checking $pkg... Installed, update available"
            read -p "Update $pkg now? [y/N]: " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                brew upgrade "$pkg" || echo "⚠️ Upgrade failed. Continuing with current version."
            fi
        else
            echo "$emoji Checking $pkg... Installed"
        fi
    fi
}

check_dependency_linux() {
    local pkg="$1"
    local emoji="$2"
    if ! command -v "$pkg" &>/dev/null; then
        echo "$emoji Checking $pkg... Not installed"
        read -p "Install $pkg now? [y/N]: " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            if command -v apt &>/dev/null; then
                sudo apt update && sudo apt install -y "$pkg"
            elif command -v dnf &>/dev/null; then
                sudo dnf install -y "$pkg"
            elif command -v pacman &>/dev/null; then
                sudo pacman -Syu "$pkg" --noconfirm
            else
                pip3 install --user "$pkg"
            fi
        else
            echo "$pkg is required. Exiting."
            exit 1
        fi
    else
        echo "$emoji Checking $pkg... Installed"
    fi
}

# --- OS Detection ---
OS_TYPE="$(uname -s)"

# --- Animated dependency check ---
deps=("python3" "ffmpeg" "yt-dlp")
dep_emojis=("🐍" "🎬" "🎥")

echo "🔍 Checking dependencies..."
for i in "${!deps[@]}"; do
    sleep 0.3
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        check_dependency_mac "${deps[$i]}" "${dep_emojis[$i]}"
    else
        check_dependency_linux "${deps[$i]}" "${dep_emojis[$i]}"
    fi
done

# --- Internet connectivity ---
if ping -c 1 youtube.com &>/dev/null; then
    echo "🌐 Checking internet connectivity... OK"
else
    echo "🌐 Checking internet connectivity... Failed"
    exit 1
fi

# --- Disk space ---
free_gb=$(df -H . | tail -1 | awk '{print $4}' | sed 's/G//')
echo "💾 Checking disk space... OK ($free_gb GB free)"

# --- Downloads Directory Detection ---
if [[ "$OS_TYPE" == "Darwin" ]]; then
    # macOS
    DOWNLOADS_DIR="$HOME/Downloads"
elif [[ "$OS_TYPE" == "Linux" ]]; then
    # Linux - try XDG first, fallback to ~/Downloads
    if command -v xdg-user-dir &>/dev/null; then
        DOWNLOADS_DIR="$(xdg-user-dir DOWNLOAD)"
    else
        DOWNLOADS_DIR="$HOME/Downloads"
    fi
else
    # Windows/WSL or other
    DOWNLOADS_DIR="$HOME/Downloads"
fi

# Create Downloads directory if it doesn't exist
if [ ! -d "$DOWNLOADS_DIR" ]; then
    mkdir -p "$DOWNLOADS_DIR"
    echo "📁 Created downloads directory: $DOWNLOADS_DIR"
else
    echo "📁 Downloads directory: $DOWNLOADS_DIR"
fi

# --- Welcome text ---
echo "=============================="
echo " YouTube Wrangler"
echo "=============================="
echo
echo "Welcome! This tool extracts YouTube URLs from text or a file, fetches video titles,"
echo "for confirmation, and downloads the videos safely to your Downloads folder."
echo
echo "You can paste any text, use a file, or quit. The script will extract URLs, show titles, and ask for confirmation."
echo
echo "Options:"
echo "1) Paste"
echo "2) File"
echo "3) Quit"
read -p "Choose an option [1-3]: " user_choice

# --- Interactive input ---
case "$user_choice" in
    1)
        echo "Enter/paste your text below. End input with an empty line:"
        input_text=""
        while true; do
            read -r line
            [[ -z "$line" ]] && break
            input_text+="$line"$'\n'
        done
        ;;
    2)
        if [ ! -f "$URL_FILE" ]; then
            echo "❌ $URL_FILE not found."
            exit 1
        fi
        input_text=$(<"$URL_FILE")
        ;;
    3)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "❌ Invalid option. Exiting."
        exit 1
        ;;
esac

# --- Extract URLs ---
urls=($(extract_urls "$input_text"))
if [ ${#urls[@]} -eq 0 ]; then
    echo "⚠️ No URLs found in the input."
    exit 1
fi

# --- Show URLs with titles ---
show_urls_with_names "${urls[@]}"
read -p "Do you want to download these videos? [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Cancelled by user."
    exit 0
fi

# --- Save URLs ---
printf "%s\n" "${urls[@]}" > "$URL_FILE"
echo "✅ URLs saved to $URL_FILE"

# --- Download function ---
download_url() {
    local url="$1"
    echo "⬇️ Downloading: $url to $DOWNLOADS_DIR"
    
    # Change to Downloads directory for download
    cd "$DOWNLOADS_DIR" || { echo "❌ Cannot access Downloads directory"; return 1; }
    
    # Use gtimeout on macOS if available, otherwise use a background process approach
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        if command -v gtimeout &>/dev/null; then
            gtimeout $PER_VIDEO_TIMEOUT yt-dlp -f "bestvideo+bestaudio" --merge-output-format mkv --continue --retries 5 --ignore-errors "$url" 2>&1 | tee -a "$OLDPWD/$LOG_FILE"
        else
            # Fallback: run yt-dlp in background with kill after timeout
            yt-dlp -f "bestvideo+bestaudio" --merge-output-format mkv --continue --retries 5 --ignore-errors "$url" 2>&1 | tee -a "$OLDPWD/$LOG_FILE" &
            local pid=$!
            ( sleep $PER_VIDEO_TIMEOUT && kill -TERM $pid 2>/dev/null ) &
            wait $pid 2>/dev/null
        fi
    else
        timeout $PER_VIDEO_TIMEOUT yt-dlp -f "bestvideo+bestaudio" --merge-output-format mkv --continue --retries 5 --ignore-errors "$url" 2>&1 | tee -a "$OLDPWD/$LOG_FILE"
    fi
    
    local exit_code=$?
    
    # Return to original directory
    cd "$OLDPWD" || { echo "❌ Cannot return to original directory"; }
    
    if [ $exit_code -eq 0 ]; then
        sed -i.bak "s|^$url|# $url|" "$URL_FILE"
        echo "✅ Completed: $url"
    else
        echo "⚠️ Failed or timed out: $url (kept in list)"
    fi
}

# --- Main loop ---
while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    download_url "$line"
done < "$URL_FILE"

# --- Retry failed ---
retry_count=0
while [ $retry_count -lt $MAX_RETRIES ]; do
    remaining_urls=$(grep -v '^#' "$URL_FILE")
    if [ -z "$remaining_urls" ]; then break; fi
    echo "🔄 Retry pass $((retry_count+1)) for remaining URLs..."
    while IFS= read -r line; do
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        download_url "$line"
    done <<< "$remaining_urls"
    retry_count=$((retry_count+1))
done

echo "🎉 All URLs processed (including retries). See $LOG_FILE for details."
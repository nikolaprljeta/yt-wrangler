# 🎯 Interactive Selection Guide

YouTube Wrangler v2.0 introduces a powerful **Interactive Selection Interface** that gives you complete control over which videos to download.

## 🚀 Quick Demo

When you run YouTube Wrangler, after extracting URLs, you'll see this interface:

```
==============================
 Select Videos to Download
==============================
Use ↑/↓ to navigate, SPACE to toggle selection, ENTER to confirm, ESC/q to quit
Selected videos are marked with [x]

> [x] Rick Astley - Never Gonna Give You Up
  [x] Me at the zoo
  [x] Charlie bit my finger - again !
  [x] David After Dentist
  [ ] Example of unselected video

Selected: 4/5 videos
```

## 🎮 Controls Reference

| Key | Action |
|-----|--------|
| `↑` / `↓` | Navigate up/down through video list |
| `SPACE` | Toggle selection for current video |
| `ENTER` | Confirm selection and start download |
| `ESC` / `q` | Cancel and exit application |

## ✨ Features

### 🎯 **Smart Defaults**
- All videos are **pre-selected** when you enter the interface
- Just uncheck the ones you don't want (much faster than selecting each one)

### 👀 **Visual Feedback**
- `>` shows which video you're currently on
- `[x]` indicates selected videos (will be downloaded)
- `[ ]` shows unselected videos (will be skipped)
- Real-time counter: `Selected: X/Y videos`

### ⚡ **Efficiency Tips**
- **Want everything?** Just press `ENTER` immediately
- **Want nothing?** Use `SPACE` to uncheck all, or press `ESC` to exit
- **Want some?** Navigate with arrows and uncheck unwanted videos with `SPACE`

## 📝 Step-by-Step Walkthrough

### 1. Launch and Select Input
```bash
./yt-wrangler.sh
```
Choose option 1 (Paste) or 2 (File)

### 2. Interactive Selection
- The interface loads with all videos selected (`[x]`)
- Navigate with `↑`/`↓` to move between videos
- Press `SPACE` on any video to toggle its selection
- Watch the counter update in real-time

### 3. Confirm and Download
- Press `ENTER` when you're happy with your selection
- See a final confirmation of selected videos
- Downloads begin automatically

## 🔧 Advanced Usage

### Batch Operations
If you frequently download from the same sources, you can:
1. Use the file option with a prepared `urls.txt`
2. Quickly uncheck videos you've already downloaded
3. Only download new content

### Quick Selection Patterns
- **All recent videos**: Navigate to older videos and uncheck them
- **Specific series**: Look for patterns in titles and select accordingly  
- **Quality filtering**: Preview titles to avoid low-quality content

## 🎬 Real-World Example

Let's say you paste a YouTube playlist URL that contains 10 videos:

1. **Interface loads**: All 10 videos selected by default
2. **Quick scan**: You see 3 videos you've already watched
3. **Navigate & uncheck**: Use arrows to find those 3, press `SPACE` to uncheck
4. **Confirm**: Press `ENTER` to download the remaining 7 videos
5. **Done**: Only the videos you want are downloaded

## 💡 Pro Tips

- **Preview before deciding**: Video titles are fetched automatically, so you can see what you're downloading
- **Use ESC for safety**: If you accidentally paste the wrong content, `ESC` exits cleanly
- **Counter awareness**: Keep an eye on "Selected: X/Y videos" to track your progress
- **Default behavior**: When in doubt, the defaults are sensible (all selected)

## 🐛 Troubleshooting

### Keyboard not responding?
- Ensure your terminal supports arrow key input
- Try using a different terminal application
- Some SSH sessions may not support interactive features

### Navigation feels sluggish?
- The interface refreshes after each keypress for accuracy
- This is normal behavior for real-time updates

### Can't see all videos?
- The interface scrolls automatically for long lists
- All videos are accessible via navigation keys

---

The Interactive Selection Interface makes YouTube Wrangler much more powerful and user-friendly. Enjoy the enhanced control over your downloads! 🎉

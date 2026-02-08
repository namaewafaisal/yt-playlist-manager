# YouTube Playlist Audio Downloader & Cover Embedder

A simple shell-script based toolkit to **download YouTube playlist audio**, **crop thumbnails to square**, and **embed cover art into Opus audio files** — all automated and easily repeatable.

This is ideal for building a local music library of playlists with clean, square album art and properly tagged Opus audio.

---

## 🧠 Features

- Downloads playlist audio in **Opus format** (best quality)
- Saves thumbnail images as **JPG**
- Skips already downloaded videos using a download archive
- Crops thumbnails to perfectly **square images**
- Embeds the thumbnail as **cover art into each `.opus` file**
- Supports using saved playlist URLs per folder  
- Interactive folder selection with **TAB auto-completion of existing folders**

---

## 📁 Repository Structure

```
yt-playlist-manager/
├── download_songs.sh
├── crop_thumbs_in_place.sh
├── embed_all_covers.sh
├── README.md
├── LICENSE
```

- `download_songs.sh` — Master script that orchestrates download → crop → embed  
- `crop_thumbs_in_place.sh` — Thumbnail cropping utility  
- `embed_all_covers.sh` — Thumbnail embed utility  
- `README.md` — This documentation  
- `LICENSE` — Your chosen license (e.g., MIT)

---

## 📦 Dependencies

Your system must have the following tools installed for the scripts to work:

### ✔ Required

| Program | Purpose |
|---------|---------|
| `yt-dlp` | Download playlist audio and thumbnails |
| `ffmpeg` | Convert & crop thumbnail images |
| `kid3-cli` | Embed cover art into Opus files |
| `bash` | Shell interpreter |

### 🔎 Optional

| Program | Purpose |
|---------|---------|
| `opusinfo` | Inspect Opus metadata (not required for core scripts) |
| Cookies file (`cookies.txt`) | For downloading restricted/age-restricted videos |

---

## 📌 Install Dependencies

### 🐧 Arch / Manjaro / EndeavourOS

```bash
sudo pacman -Syu yt-dlp ffmpeg kid3-cli
```

### 🐧 Ubuntu / Debian

```bash
sudo apt update
sudo apt install yt-dlp ffmpeg kid3-cli
```

> On some Ubuntu/Debian releases, `yt-dlp` may not be in the main repos or may be outdated. In that case you can:
>
> - Install via pip:  
>   ```bash
>   python3 -m pip install yt-dlp
>   ```
> - Or download a standalone binary from the official yt-dlp release page.

### 🐧 Fedora

```bash
sudo dnf install yt-dlp ffmpeg kid3-cli
```

### 🍺 macOS (Homebrew)

```bash
brew install yt-dlp ffmpeg kid3
```

> On macOS, `kid3-cli` may install as `kid3` rather than `kid3-cli`. Adjust commands accordingly.

### 💡 If a dependency isn’t available

If a package isn’t available via your distribution’s package manager:

- Try installing using `pip` for Python tools (`yt-dlp`)
- Use standalone binaries where available
- Compile from source if no binary packages exist
- On Windows, use WSL (Windows Subsystem for Linux) with the commands above

---

## 📌 Cookies (Optional)

For some videos that require authentication (age-restricted or region blocked), exporting your YouTube browser cookies may help.

1. Export cookies in **Netscape format** (using a browser extension).  
2. Save the file as:

```
~/cookies.txt
```

3. The download script will use it automatically.

⚠ Cookies contain session data — **do not commit them to version control**.

---

## 🚀 Usage

### 1) Run the master script

From your project root (or any folder holding your music):

```bash
cd ~/Music
bash download_songs.sh
```

You will be prompted:

```
Enter playlist folder name (TAB to autocomplete folders, ENTER to auto-use playlist title):
>
```

- Type an existing playlist folder (press TAB to complete)  
- Or press ENTER for a new folder

If the folder already contains a `playlist_url.txt`, the script will reuse it.  
Otherwise you’ll be prompted to enter the playlist URL.

---

### 2) Provide the playlist URL

If the folder does not already contain a saved playlist URL, you’ll see:

```
Enter playlist URL:
>
```

Paste the YouTube playlist link here.

---

### 3) Workflow

The script will now:

✔ Download new / missing tracks into the playlist folder  
✔ Update `downloaded.txt` with downloaded video IDs  
✔ Crop thumbnails to square (`.jpg`)  
✔ Embed cover art into corresponding `.opus` files

---

## 📁 Re-Running the Script

If you run the script again and enter the **same playlist folder name**:

- The script reads the stored playlist URL from `playlist_url.txt`
- Uses `downloaded.txt` to skip previously downloaded tracks
- Downloads only new videos added to the playlist since last run

This makes updating playlists convenient and non-destructive.

---

## 🧠 How It Works

1. **Download with `yt-dlp`**  
   - Downloads audio as `.opus`  
   - Downloads thumbnails and converts to `.jpg`  
   - Saves video IDs in `downloaded.txt` to avoid duplicates

2. **Crop Thumbnails**
   - Uses `ffmpeg` to crop each `.jpg` to a square by trimming sides

3. **Embed Covers**
   - Uses `kid3-cli` to embed the cropped `.jpg` into the `.opus` file as cover art

---

## 📜 License

This project is released under the **MIT License** — see the `LICENSE` file for details.

---

## ❤️ Acknowledgements

Thanks to:

- **yt-dlp** for robust YouTube downloading  
- **ffmpeg** for powerful media processing  
- **kid3-cli** for metadata editing  

---

Enjoy building your local playlist library with embedded cover art!
::contentReference[oaicite:0]{index=0}

**This README was generated by AI**

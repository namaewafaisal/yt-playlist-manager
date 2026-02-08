#!/bin/bash

# Don't exit on a single failed yt-dlp download
set -euo pipefail

# Enable tab completion for directory names
echo "Enter playlist folder name (TAB auto-complete directories, ENTER to auto-use playlist title):"
read -e -p "> " TARGET

if [[ -z "$TARGET" ]]; then
  echo "No folder name provided. Exiting."
  exit 1
fi

URLFILE="$TARGET/playlist_url.txt"

if [[ -d "$TARGET" && -f "$URLFILE" ]]; then
  PLAYLIST_URL=$(<"$URLFILE")
  echo "Using saved URL from $URLFILE:"
  echo "  $PLAYLIST_URL"
else
  echo "Enter playlist URL:"
  read PLAYLIST_URL
  mkdir -p "$TARGET"
  echo "$PLAYLIST_URL" >"$URLFILE"
  echo "Saved playlist URL in $URLFILE"
fi

echo "======== Downloading into folder: $TARGET ========"

# Run download but allow non-zero exit so script continues
yt-dlp \
  --cookies ~/cookies.txt \
  -x \
  --audio-format opus \
  --audio-quality 0 \
  --write-thumbnail \
  --convert-thumbnails jpg \
  --embed-metadata \
  --download-archive "$TARGET/downloaded.txt" \
  -o "$TARGET/%(playlist_index)02d - %(title)s.%(ext)s" \
  "$PLAYLIST_URL" || echo "⚠ Some downloads failed — continuing..."

echo
echo "======== Running Crop Script ========"
bash crop_thumbs_in_place.sh "$TARGET"
echo

echo "======== Running Embed Script ========"
bash embed_all_covers.sh "$TARGET"
echo

echo "===== All Done for $TARGET ====="

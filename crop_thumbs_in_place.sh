#!/bin/bash
# Usage: crop_thumbs_in_place.sh <target_directory>

if [[ -z "$1" ]]; then
  echo "Usage: $0 <folder>"
  exit 1
fi

TARGET_DIR="$1"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: folder '$TARGET_DIR' does not exist."
  exit 1
fi

cd "$TARGET_DIR" || exit

echo "Cropping JPG thumbnails in place (center crop square) in: $TARGET_DIR"

for img in *.jpg; do
  # Only process JPG
  if [[ ! -f "$img" ]]; then
    continue
  fi

  # Get dimensions
  read W H < <(ffprobe -v error -select_streams v:0 \
    -show_entries stream=width,height \
    -of csv=p=0 "$img")

  if [[ "$W" -eq "$H" ]]; then
    echo "  Skipping (already square): $img"
    continue
  fi

  echo "  Cropping: $img ($W x $H)"

  tmp="${img}.tmp.jpg"

  ffmpeg -y -i "$img" \
    -vf "crop=ih:ih:(iw-ih)/2:0" \
    "$tmp" -loglevel error

  if [[ -f "$tmp" ]]; then
    mv "$tmp" "$img"
    echo "    ✔ Overwrote with square version"
  else
    echo "    ❗ Crop failed for $img"
  fi
done

echo "Done cropping thumbnails in place."

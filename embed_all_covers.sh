#!/bin/bash
# Usage: embed_all_covers.sh <target_directory>

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

echo "Embedding covers into all .opus files in: $TARGET_DIR"

for opus in *.opus; do
  base="${opus%.opus}"
  jpg="${base}.jpg"
  webp="${base}.webp"

  # Find thumbnail
  if [[ -f "$jpg" ]]; then
    thumb="$jpg"
  elif [[ -f "$webp" ]]; then
    thumb="$webp"
  else
    echo "  ✖ No thumbnail for $opus"
    continue
  fi

  # If webp, convert to jpg
  if [[ "$thumb" == *.webp ]]; then
    echo "  Converting $thumb → $jpg"
    ffmpeg -i "$thumb" "$jpg" -loglevel error
    thumb="$jpg"
    rm "$webp"
  fi

  echo "  Embedding cover into $opus"
  kid3-cli -c "set picture:'$thumb' '1'" "$opus"
done

echo "Done embedding covers."

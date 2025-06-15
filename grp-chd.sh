#!/bin/bash

set -e
shopt -s nullglob

# Color functions
bold() { echo -e "\033[1m$1\033[0m"; }
green() { echo -e "\033[32m$1\033[0m"; }
yellow() { echo -e "\033[33m$1\033[0m"; }
blue() { echo -e "\033[34m$1\033[0m"; }

TARGET_DIR="."
while [[ $# -gt 0 ]]; do
    case "$1" in
    --dir=*)
        TARGET_DIR="${1#--dir=}"
        shift
        ;;
    *)
        echo "Usage: $0 [--dir=<directory>]"
        exit 1
        ;;
    esac
    case "$1" in
    --help | -h)
        echo "Usage: $0 [--dir=<directory>]"
        echo "Organizes .m3u and .chd files into directories based on .m3u filenames."
        exit 0
        ;;
    esac
done

cd "$TARGET_DIR"

bold "🎮 Organizing .m3u and .chd files..."

# Find all .m3u files in current directory
find . -maxdepth 1 -type f -iname "*.m3u" -print0 | while IFS= read -r -d '' m3u_file; do
    # Remove leading ./ if present
    m3u_file="${m3u_file#./}"

    bold "\n▶️ Processing playlist: $m3u_file"

    # Set directory name to full .m3u filename
    dir_name="$m3u_file"

    # Temporarily rename to avoid conflict
    tmp_m3u="${m3u_file}.tmpmoving"
    mv -- "$m3u_file" "$tmp_m3u"
    blue "📄 Temporary rename: $tmp_m3u"

    # Create directory with .m3u name
    mkdir -p -- "$dir_name"
    green "📂 Created directory: $dir_name"

    # Move .m3u file into the new directory
    mv -- "$tmp_m3u" "$dir_name/$m3u_file"
    green "🚚 Moved .m3u into $dir_name"

    # Get base name (without extension)
    base_name="${m3u_file%.m3u}"

    # Move all matching .chd files
    find . -maxdepth 1 -type f -iname "${base_name}*.chd" -print0 | while IFS= read -r -d '' chd_file; do
        mv -- "$chd_file" "$dir_name/"
        green "🚚 Moved CHD: ${chd_file#./} → $dir_name/"
    done
done

bold "\n✅ All done!"

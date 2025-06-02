#!/bin/bash

actual_folder=" "

folder_project="$HOME/Projects/wallpaper-changer"
folder_wallpapers="$HOME/Pictures/Wallpapers/$actual_folder"

current=$(cat "$folder_project"/current_wallpaper.txt)

UpdateWallpapers() {
    ls -1 "$folder_wallpapers" > "$folder_project"/wallpapers.txt
    find "$folder_wallpapers" -maxdepth 1 -type f | wc -l > "$folder_project/quantity.txt"
}

ChangeWallpaper() {
    quantity=$(cat "$folder_project"/quantity.txt)

    if (($1 == 0)); then
        new=$((current - 1))
    elif (($1 == 1)); then
        new=$((current + 1))
    fi

    if (( new < 1 )); then
        new=$quantity
    elif (( new > $quantity )); then
        new=1
    fi

    wallpaper=$(sed -n "${new}p" "$folder_project"/wallpapers.txt)

    feh --bg-fill "$folder_wallpapers/$wallpaper"
    
    echo "$new" > "$folder_project"/current_wallpaper.txt

    wal -i "$folder_wallpapers/$wallpaper"
    python3 "$folder_project/colors-wal.py"
    pkill -x polybar
    polybar &
}

init() {
    wallpaper=$(sed -n "${current}p" "$folder_project"/wallpapers.txt)
    feh --bg-fill "$folder_wallpapers/$wallpaper"
}

case "$1" in 
    0) ChangeWallpaper 0 ;;
    1) ChangeWallpaper 1 ;;
    2) UpdateWallpapers ;;
    *) init ;;
esac

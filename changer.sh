#!/bin/bash
folder_project="$HOME/Projects/wallpaper-changer"
folder_wallpapers="$HOME/Pictures/Wallpapers/favs"

quantity=$(ls -1 "$folder_wallpapers" | wc -l)
current=$(cat "$folder_project"/number_wallpaper.txt)

UpdateWallpapers() {
    ls -1 "$folder_wallpapers" > "$folder_project"/wallpapers.txt && exit 0
}

ChangeWallpaper() {
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

    echo $new > "$folder_project"/number_wallpaper.txt
}

init() {
    wallpaper=$(sed -n "${current}p" "$folder_project"/wallpapers.txt)
    feh --bg-fill "$folder_wallpapers/$wallpaper"
}

if (($1 == 0)); then
    ChangeWallpaper 0
elif (($1 == 1)); then
    ChangeWallpaper 1
elif (($1 == 2)); then
    UpdateWallpapers
else
    init
fi

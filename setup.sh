#!/bin/bash

# === Configuration ===
project_dir="$(dirname "$(realpath "$0")")"
wallpaper_dir="$HOME/Pictures/Wallpapers/"

current_file="$project_dir/current_wallpaper.txt"
wallpapers_file="$project_dir/wallpapers.txt"
quantity_file="$project_dir/quantity.txt"
changer_script="$project_dir/changer.sh"
color_script="$project_dir/colors-wal.py"

sxhkdrc="$HOME/.config/sxhkd/sxhkdrc"
binding="super + alt + {Left,Right,Up}"
commands_bind="     $project_dir/changer.sh {0,1,2}"

echo "📁 Project directory: $project_dir"
echo "🖼️ Wallpaper directory: $wallpaper_dir"

# === Generate wallpapers.txt ===
if [[ -d "$wallpaper_dir" ]]; then
    echo "📄 Generating wallpapers.txt..."
    touch "$wallpapers_file"
else
    echo "❌ Wallpaper directory not found: $wallpaper_dir"
    exit 1
fi

# === Generate quantity.txt ===
echo "📊 Counting wallpapers..."
touch "$quantity_file"

# === Create current_wallpaper.txt if it doesn't exist ===
if [[ ! -f "$current_file" ]]; then
    echo "🆕 Creating current_wallpaper.txt with initial value 0"
    echo 1 > "$current_file"
else
    echo "✔️ current_wallpaper.txt already exists, keeping current value"
fi

# === Make changer.sh and colores-wal.py executable ===
echo ""
if [[ -f "$changer_script" ]]; then
    chmod +x "$changer_script"
    echo "✔️ changer.sh marked as executable"
else
    echo "⚠️ changer.sh not found"
fi

if [[ -f "$color_script" ]]; then
    chmod +x "$color_script"
    echo "✔️ colores-wal.py marked as executable"
else
    echo "⚠️ colores-wal.py not found"
fi

# === Asign sxhkd binds ===
if grep -Fxq "$binding" "$sxhkdrc"; then
    echo "ℹ️ Binding already exists in sxhkdrc."
else
    echo -e "\n$binding\n$commands_bind" >> "$sxhkdrc"
    echo "✅ Binding added to sxhkdrc."
fi

# Reload sxhkd to apply changes
if pkill -USR1 -x sxhkd; then
    echo "🔄 sxhkd reloaded successfully."
else
    echo "⚠️ Failed to reload sxhkd. Is it running?"
fi

# === Done ===
echo ""
echo "✅ Setup completed. Files created:"
ls -1 "$current_file" "$wallpapers_file" "$quantity_file"
./changer.sh 2 &

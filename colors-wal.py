import os


home = os.path.expanduser("~")
wal_colors_file = os.path.join(home, ".cache", "wal", "colors")
polybar_colors_file = os.path.join(home, ".config", "polybar", "colors_wal.ini")
vim_colors_src = os.path.join(home, ".cache", "wal", "colors-wal.vim")
rofi_colors_src = os.path.join(home, ".cache", "wal", "colors-rofi-dark.rasi")
vim_colors_dst = os.path.join(home, ".vim", "colors", "colorsWal.vim")
rofi_colors_dst = os.path.join(home, ".config", "rofi", "colors", "colorsWal.rasi")


# Generate Polybar colors config
if os.path.exists(wal_colors_file):
    with open(polybar_colors_file, "w") as polybar_file:
        polybar_file.write("[colors]\n")
        with open(wal_colors_file, "r") as wal_file:
            for index, line in enumerate(wal_file):
                polybar_file.write(f'color{index} = {line}')
else:
    notify-send "Wal colors file not found."


# Move Vim colorscheme
if os.path.exists(vim_colors_src):
    os.rename(vim_colors_src, vim_colors_dst)
else:
    notify-send "Vim wal colors file not found."


# Move Rofi theme
if os.path.exists(rofi_colors_src):
    os.rename(rofi_colors_src, rofi_colors_dst)
else:
    notify-send "Rofi wal theme not found."

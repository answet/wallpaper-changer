This uses `feh`, `pywal` and `sxhkd`
## Install
```
chmod +x setup.sh
```
```
./setup.sh
```
## Change the wallpaper folder
The default path is `~/Pictures/Wallpapers`. To change it, modify the following line in `change.sh`:
```
#!/bin/bash
...    
folder_wallpapers="$HOME/Pictures/Wallpapers/"   # <-- modify this variable
...
```

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
folder_wallpapers="$HOME/Pictures/Wallpapers"   # <-- modify this variable
...
```

## Keyboard Shortcuts (sxhkd)

These keybindings are managed using `sxhkd`:

- `Super + Alt + Left Arrow` → Go to the **previous** wallpaper  
- `Super + Alt + Right Arrow` → Go to the **next** wallpaper  
- `Super + Alt + Up Arrow` → **Refresh** the list of available wallpapers in the folder

Make sure `sxhkd` is running to use these shortcuts.

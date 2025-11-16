#!/bin/bash
wallDIR="$HOME/Pictures/wallpapers"
copy_wallpaper="$HOME/Pictures/current_wallpaper"
current_wallpaper=$(hyprctl hyprpaper listloaded)
wallpaper=$(find "$wallDIR" -type f ! -name "$(basename "$current_wallpapaer")" | shuf -n 1)
hyprctl hyprpaper preload "$wallpaper"
hyprctl hyprpaper wallpaper ,"$wallpaper"
cp -r "$wallpaper" "$copy_wallpaper"
notify-send "Wallpaper Changed" "NOW: $(basename "$wallpaper")"
echo "$(basename "$wallpaper")" > "$HOME/.cache/last_wallpaper"

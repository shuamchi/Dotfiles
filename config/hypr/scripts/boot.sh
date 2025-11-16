#!/bin/bash
sleep 1
copy_wallpaper="$HOME/Pictures/current_wallpaper"
hyprctl hyprpaper reload ,"$copy_wallpaper"

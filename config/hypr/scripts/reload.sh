killall waybar
waybar &
sleep 0.1
hyprctl reload &
sleep 0.1
killall hyprpaper &
sleep 0.1
hyprpaper & /home/home/.config/hypr/scripts/boot.sh

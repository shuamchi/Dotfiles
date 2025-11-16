#!/bin/sh

# Set some variables
wall_dir="$HOME/Pictures/wallpapers"
cacheDir="$HOME/.cache/home"
copy_wallpaper="$HOME/Pictures/current_wallpaper"
last_wall=$(cat "$HOME/.cache/last_wallpaper" 2>/dev/null)

# Create cache dir if not exists
[ -d "$cacheDir" ] || mkdir -p "$cacheDir"

rofi_command="rofi -dmenu -theme $HOME/.config/rofi/WallSelect.rasi"

# Detect number of cores and set a sensible number of jobs
get_optimal_jobs() {
    cores=$(nproc)
    if [ "$cores" -le 2 ]; then
        echo 2
    elif [ "$cores" -gt 4 ]; then
        echo 4
    else
        echo $((cores - 1))
    fi
}

PARALLEL_JOBS=$(get_optimal_jobs)

process_func_def='process_image() {
    imagen="$1"
    nombre_archivo=$(basename "$imagen")
    cache_file="${cacheDir}/${nombre_archivo}"
    md5_file="${cacheDir}/.${nombre_archivo}.md5"
    lock_file="${cacheDir}/.lock_${nombre_archivo}"
    current_md5=$(xxh64sum "$imagen" | cut -d " " -f1)
    (
        flock -x 9
        if [ ! -f "$cache_file" ] || [ ! -f "$md5_file" ] || [ "$current_md5" != "$(cat "$md5_file" 2>/dev/null)" ]; then
            magick "$imagen" -resize 500x500^ -gravity center -extent 500x500 "$cache_file"
            echo "$current_md5" > "$md5_file"
        fi
        rm -f "$lock_file"
    ) 9>"$lock_file"
}'

export process_func_def cacheDir wall_dir

# Clean old locks before starting
rm -f "${cacheDir}"/.lock_* 2>/dev/null || true

# Process files in parallel
find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | \
    xargs -0 -P "$PARALLEL_JOBS" -I {} sh -c "$process_func_def; process_image \"{}\""

# Clean orphaned cache files and their locks
for cached in "$cacheDir"/*; do
    [ -f "$cached" ] || continue
    original="${wall_dir}/$(basename "$cached")"
    if [ ! -f "$original" ]; then
        nombre_archivo=$(basename "$cached")
        rm -f "$cached" \
            "${cacheDir}/.${nombre_archivo}.md5" \
            "${cacheDir}/.lock_${nombre_archivo}"
    fi
done

# Clean any remaining lock files
rm -f "${cacheDir}"/.lock_* 2>/dev/null || true

### --- BUILD WALL LIST --- ###
mapfile -t wall_list < <(find "$wall_dir" -type f -printf "%f\n" | LC_ALL=C sort )

### --- FIND LAST SELECTED INDEX --- ###
selected_index=0

for i in "${!wall_list[@]}"; do
    if [ "${wall_list[$i]}" = "$last_wall" ]; then
        selected_index=$i
        break
    fi
done


# Launch rofi
wall_selection=$(printf "%s\n" "${wall_list[@]}" |
    while IFS= read -r A; do
        printf '%s\000icon\037%s/%s\n' "$A" "$cacheDir" "$A"
    done |  $rofi_command -selected-row "$selected_index" )

#do nothing
[ -z "$wall_selection" ] && exit 0
# Set wallpaper
    hyprctl hyprpaper preload "${wall_dir}/${wall_selection}"
    hyprctl hyprpaper wallpaper ,"${wall_dir}/${wall_selection}"
    cp -r  "${wall_dir}/${wall_selection}" "$copy_wallpaper"
    notify-send "Wallpaper Changed" "NOW: $(basename "$wall_selection")"
    echo "$wall_selection" > "$HOME/.cache/last_wallpaper"

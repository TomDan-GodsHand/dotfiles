#!/usr/bin/env bash

# 从第一个参数获取 sleep 时间（默认值 5s）
SLEEP_TIME="${1:-5s}"

WALLPAPER_DIR="$HOME/Wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# 获取随机壁纸（排除当前壁纸）
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# 应用新壁纸前等待指定时间
sleep "$SLEEP_TIME"
hyprctl hyprpaper reload ,"$WALLPAPER"
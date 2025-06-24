#!/bin/bash


# 关闭 waybar
killall waybar
pkill waybar

path="$HOME/.config/waybar/scripts"
config_file="$HOME/.config/waybar/config"
# 获取显示器名字
downMonitor=$(bash "$path/outputDown.sh")
upMonitor=$(bash "$path/outputUp.sh")

echo "upMonitor: $upMonitor"
echo "downMonitor: $downMonitor"

tmp_file="$(mktemp)"

# 用 sed 替换 bottombar 的 output 字段
awk -v monitor="$downMonitor" '
    BEGIN {in_bottombar=0}
    /"name": *"bottombar"/ {in_bottombar=1}
    in_bottombar && /"output":/ {
        sub(/"output": *"[^"]*"/, "\"output\": \"" monitor "\"")
        in_bottombar=0
    }
    {print}
' "$config_file" > "$tmp_file" && mv "$tmp_file" "$config_file"

awk -v monitor="$upMonitor" '
    BEGIN {in_topbar=0}
    /"name": *"topbar"/ {in_topbar=1}
    in_topbar && /"output":/ {
        sub(/"output": *"[^"]*"/, "\"output\": \"" monitor "\"")
        in_topbar=0
    }
    {print}
' "$config_file" > "$tmp_file" && mv "$tmp_file" "$config_file"

# 重新启动 waybar
waybar
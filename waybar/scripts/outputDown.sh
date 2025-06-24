#!/bin/bash

hyprctl monitors | awk '
/^Monitor/ {name=$2}
/at [0-9]+x[0-9]+/ {
    if (match($0, /at [0-9]+x([0-9]+)/, arr)) {
        y = arr[1]
        if (y > max_y) {
            max_y = y
            bottom_name = name
        }
    }
}
END { if (bottom_name) print bottom_name }
'
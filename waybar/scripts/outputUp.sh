#!/bin/bash

hyprctl monitors | awk '/^Monitor/ {name=$2} /at [0-9]+x0/ {print name}'
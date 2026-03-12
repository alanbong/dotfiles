#!/usr/bin/env bash

CPU_USAGE=$(top -l 2 -n 0 -F | grep "CPU usage" | tail -1 | awk '{usage=$3+$5; printf "%.0f%%", usage}')

sketchybar --set "$NAME" label="$CPU_USAGE"

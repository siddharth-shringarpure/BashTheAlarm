#!/bin/bash

function countdown_timer {
    local target_time="$1"
    local curr_time
    local remaining

    while true; do
        curr_time=$(date +"%H%M")

        if [ "$curr_time" == "$target_time" ]; then
            echo "It's wake-up time!"
            break
        else
            remaining=$(( ($(date -d "$target_time" +%s) - $(date +%s)) / 60 ))
            echo "Time until wake-up: $remaining minutes"
            sleep 60
        fi
    done
}

countdown_timer "$1"

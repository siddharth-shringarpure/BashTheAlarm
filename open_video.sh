#!/bin/bash
#
# Opens a video of choice in the user's preferred web browser, or music player application

function open_video {
    local url="$1"
    echo "Opening video: $url"
    xdg-open "$url" &
    sleep 10  # Allow time for browser to open
}

open_video "$1"


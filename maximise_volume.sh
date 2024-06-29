#!/bin/bash
#
# Set user's volume level to 100% for PulseAudio instances

function maximise_volume {
    
    # Check if PulseAudio is running
    if pactl info > /dev/null 2>&1; then
         
        # Get default sink (output device)
        sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

        # Set volume to 100%
        pactl set-sink-volume "$sink" 1.0
	return 0
    else
        echo "PulseAudio is not running. Unable to adjust volume."
	return 1
    fi
}

maximise_volume


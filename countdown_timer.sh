#!/bin/bash

function validate_time_input {
    local input_time="$1"
    if [[ ! $input_time =~ (([0|1][0-9]|[2][0-3])[0-5][0-9]) ]]; then
        echo "Invalid time format, please use HHMM format."
        exit 1
    fi
}

function countdown_timer {
    local target_time="$1"
    local curr_time
    local remaining

    validate_time_input "$target_time"

    while true; do
        curr_time=$(date +"%H%M")

        if [ "$curr_time" == "$target_time" ]; then
            echo "It's wake-up time!"
            break
        else
            target_epoch=$(date -d "$target_time" +%s)
            curr_epoch=$(date +%s)

            # Handle cases where target time is earlier than current time
            if [ "$target_epoch" -lt "$curr_epoch" ]; then
                target_epoch=$(date -d "tomorrow $target_time" +%s)
                target_time=$()
            fi


            # Format remaining time

            remaining_seconds=$((target_epoch - curr_epoch))
            remaining_minutes=$((remaining_seconds / 60))
            remaining_hours=$((remaining_minutes / 60))

            case 1 in
                $(($remaining_seconds < 60)))
                    echo "Time until wake-up: $remaining_seconds seconds"
                    sleep 10
                    ;;

                $(($remaining_minutes < 10)))
                    echo "Time until wake-up: $remaining_minutes minutes"
                    sleep 60
                    ;;

                $(($remaining_minutes >= 10)))
                    echo "Time until wake-up: $remaining_minutes minutes"
                    sleep 300
                    ;;

                $(($remaining_hours >= 1 && $remaining_hours < 2)))
                    echo "Time until wake-up: $remaining_hours hours, $((remaining_minutes % 60)) minutes"
                    sleep 300  # Sleep for 5 minutes
                    ;;

                $(($remaining_hours >= 2)))
                    echo "Time until wake-up: $remaining_hours hours"
                    sleep 3600  # Sleep for 1 hour
                    ;;
            esac
        fi
    done
}

countdown_timer "$1"

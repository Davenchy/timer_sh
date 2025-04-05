#!/usr/bin/env bash
# Show visual countdown for a timer

BIN=$(basename "$0")
ROOT=$(dirname "$(realpath "$0")")

# source utilities
source "$ROOT/utils.sh"

# check for required commands
required column

timer_name="$1"
file="/tmp/$timer_name.timer"

# check for required arguments
if [[ -z "$timer_name" ]]; then
  echo "Usage: $BIN <timer_name>"
  exit 1
fi

# check if timer exists
if [[ -f "$file" ]]; then
  IFS=":" read -r pid task duration start_time < "$file"
  if validate_timer_by_pid "$pid" "$file"; then
    while [[ $(calculate_remaining_time_seconds "$start_time" "$duration") -gt 0 ]]; do
      clear
      echo -e "Remaining: $(calculate_remaining_time "$start_time" "$duration")"
      sleep 1
    done
    echo "Timer $timer_name completed!"
    exit 0
  fi
fi

echo "No timer found with name $timer_name"
exit 1

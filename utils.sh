# This file contains utility functions for the timer scripts.

# Play a sound file.
play() {
  ROOT=$(dirname "$(realpath "$0")")
  mpv --no-terminal "$ROOT/$1.mp3" &
}

# Check if a command is installed.
required() {
  if ! command -v "$1" &> /dev/null; then
    echo "Error: $1 is not installed."
    exit 1
  fi
}

# Validate a timer by its PID and cleanup if process not running
validate_timer_by_pid() {
  local pid=$1
  local timer_file=$2

  if ps -p "$pid" >/dev/null 2>&1; then
    return 0
  else
    rm -f "$timer_file"
    return 1
  fi
}

# parse time input to seconds
parse_time_input() {
  input="$1"
  seconds=0

  while [[ "$input" =~ ^([0-9]+)([dhms]) ]]; do
    value="${BASH_REMATCH[1]}"
    unit="${BASH_REMATCH[2]}"
    case "$unit" in
      s) seconds=$((seconds + value)) ;;
      m) seconds=$((seconds + value * 60)) ;;
      h) seconds=$((seconds + value * 3600)) ;;
      d) seconds=$((seconds + value * 86400)) ;;
      *) echo "Error: Invalid unit: $unit, expected [s|m|h|d]" && exit 1 ;;
    esac
    input="${input/${BASH_REMATCH[0]}/}"
  done

  echo "$seconds"
}

# Display time in a human-readable format
displaytime() {
  local T="$1"
  local D="$((T/60/60/24))"
  local H="$((T/60/60%24))"
  local M="$((T/60%60))"
  local S="$((T%60))"
  (( $D > 0 )) && printf '%dd ' $D
  (( $H > 0 )) && printf '%dh ' $H
  (( $M > 0 )) && printf '%dm ' $M
  printf '%ds\n' $S
}

# get current time formatted
current_time() {
  date +"%Y-%m-%d %H:%M:%S"
}

# Calculate the remaining time for a timer and return it in seconds
calculate_remaining_time_seconds() {
  local start_time="$1"
  local duration="$2"
  local current_time=$(current_time)
  local elapsed_time=$((($(date -d "$current_time" +%s) - $(date -d "$start_time" +%s))))
  local remaining_time=$((duration - elapsed_time))
  printf "%d\n" "$remaining_time"
}

# Calculate the remaining time for a timer
calculate_remaining_time() {
  displaytime "$(calculate_remaining_time_seconds "$1" "$2")"
}

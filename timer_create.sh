#!/usr/bin/env bash
# This script is a timer instance,
# where it creates a timer instance lock file with timer info

BIN=$(basename "$0")
ROOT=$(dirname "$(realpath "$0")")

# source utilities
source "$ROOT/utils.sh"

task="$1"
duration="$(parse_time_input "$2")"
human_duration=$(displaytime "$duration"); [ $? -eq 0 ] || exit 1
lock_file="/tmp/$task.timer"

# check for required commands
required mpv
required awk
required notify-send

# check if task and duration are provided
if [ -z "$task" ] || [ -z "$duration" ]; then
    echo -e "Usage: $BIN <task> <duration>\n\te.g. $BIN 'take a break' 15m"
    exit 1
fi

# check if timer is already running
if [ -e "$lock_file" ]; then
  PID=$(cat "$lock_file" | awk -F: '{print $1}')
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "Stale lock detected for PID $PID. Removing..."
    rm -f "$lock_file"
  else
    echo "Timer for task '$task' is already running with PID $PID."
    exit 1
  fi
fi

# create timer lock file with timer info
echo "$$:$task:$duration:$(current_time)" > "$lock_file"

# clean on signals and exit
trap 'rm -f "$lock_file"; play canceled; exit 1' INT TERM QUIT EXIT

# run timer
play created
notify-send "Timer" "Starting timer for task '$task' for $human_duration"
echo "$$: Timer $task started for duration $human_duration!"
sleep "$duration"
notify-send "Timer" "Timer '$task' completed!"
play completed

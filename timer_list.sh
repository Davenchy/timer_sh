#!/usr/bin/env bash
# This script manages timer instances running in the background

ROOT=$(dirname "$(realpath "$0")")

# source utilities
source "$ROOT/utils.sh"

# check for required commands
required column

{
  echo -e "PID\tTimer\tDuration\tRemaining"
  shopt -s nullglob
  for file in /tmp/*.timer; do
    IFS=":" read -r pid task duration start_time < "$file"
    if validate_timer_by_pid "$pid" "$file"; then
      echo -e "$pid\t$task\t$(displaytime "$duration")\t$(calculate_remaining_time "$start_time" "$duration")"
    fi
  done
  shopt -u nullglob
} | column -t -s $'\t'

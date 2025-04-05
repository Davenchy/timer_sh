#!/usr/bin/env bash
# Kill a timer instance by ids timerID

BIN=$(basename "$0")
ROOT=$(dirname "$(realpath "$0")")

# source utilities
source "$ROOT/utils.sh"

# check for required commands
required column

timerID="$1"

# check for required arguments
if [[ -z "$timerID" ]]; then
  echo "Usage: $BIN <timerID>"
  exit 1
fi

# try to use timerID as PID and kill it
if kill -USR1 "$timerID" 2&> /dev/null; then
  echo "Timer with PID $timerID killed successfully!"
  exit 0
fi

# try to use timerID as task name and kill it
if [[ -f /tmp/$timerID.timer ]]; then
  PID=$(cat /tmp/$timerID.timer | cut -d: -f1)

  if kill -USR1 "$PID" 2&> /dev/null; then
    echo "Timer with task name $timerID and PID $PID killed successfully!"
    exit 0
  else
    echo "Failed to kill timer with task name $timerID and PID $PID"
    exit 1
  fi
fi

echo "No timer found with ID $timerID"
exit 1

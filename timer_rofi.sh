#!/usr/bin/env bash
# Uses rofi to create, list and kill timers

ROOT=$(dirname "$(realpath "$0")")

source "$ROOT/utils.sh"

required rofi

bin="$ROOT/timer.sh"
CREATE="Create New Timer"

timers=$($bin list | tail -n +2)
selected=$(echo -e "$CREATE\n$timers" | rofi -dmenu -p "Select timer to kill")

case "$selected" in
  "") exit 0;;
  $CREATE)
    name=$(echo -e "Timer1\nTimer2\nTimer3\nTimer4" | rofi -dmenu -p "Timer Name")
    [ -z "$name" ] && exit 1
    duration=$(echo -e "30s\n1m\n5m\n10m\n15m\n20m\n30m\n45m\n1h" | rofi -dmenu -p "Timer Duration")
    [ -z "$duration" ] && exit 1
    "$bin" create "$name" "$duration"
  ;;
  *)
    if [ -n "$selected" ]; then
      timer=$(echo "$selected" | awk '{print $1}')
      exec "$bin" kill "$timer"
      if [ $? -ne 0 ]; then
        rofi -dmenu -p "Failed to kill timer"
      fi
    fi
  ;;
esac

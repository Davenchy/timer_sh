#!/usr/bin/env bash
# A CLI tool that manages named timers that run in the background.

BIN=$(basename "$0")
ROOT=$(dirname "$(realpath "$0")")

show_help() {
  echo -e "Usage:"
  echo -e "\t$BIN create <timer_name> <duration>\n\t\tcreate a timer with a given name and duration.\n\t\t<duration>: is the same as passed to the sleep command. (e.g. 10s, 1m, 1h, etc...)\n"
  echo -e "\t$BIN kill <timerID>\n\t\tkill a timer by its ID.\n\t\t<timerID>: use timer name or PID as shown in the list subcommand\n"
  echo -e "\t$BIN countdown <timer_name>\n\t\tshow a visual countdown for a timer by its name.\n\t\t<timer_name>: use timer name as shown in the list subcommand\n"
  echo -e "\t$BIN list\n\t\tlist all timers\n"
  echo -e "\t$BIN rofi\n\t\trofi integration for creating, listing, and killing timers\n"
  exit 1
}

case "$1" in
  create)
    if [[ -z "$2" || -z "$3" ]]; then
      echo "Error: Timer name and duration are required."
      show_help
    fi
    "$ROOT/timer_create.sh" "$2" "$3"
  ;;
  kill)
    if [[ -z "$2" ]]; then
      echo "Error: Timer ID is required."
      show_help
    fi
    "$ROOT/timer_kill.sh" "$2"
  ;;
  countdown)
    if [[ -z "$2" ]]; then
      echo "Error: Timer name is required."
      show_help
    fi
    "$ROOT/timer_countdown.sh" "$2"
  ;;
  list) "$ROOT/timer_list.sh" ;;
  rofi) "$ROOT/timer_rofi.sh" ;;
  *) show_help ;;
esac

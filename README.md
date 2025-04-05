# 🕒 Bash Timer CLI

A simple CLI tool written in Bash to manage named timers that run in the background. Great for quick reminders, Pomodoro sessions, or task timing.

---

## 🚀 Features

- Create named background timers
- Auto notifications and sound alerts on complete or cancel
- Kill timers manually by name or PID
- List active timers in a formatted table
- Show remaining time
- Show visual countdown
- No dependencies on systemd or external services
- Complex time format support. e.g. `1h30m15s`
- Rofi integration for selecting timers (optionally supported)

---

## 📦 Usage

```bash
./timer.sh create <timer_name> <duration>
./timer.sh kill <timerID>
./timer.sh countdown <timer_name>
./timer.sh list
./timer.sh rofi
```

### 🔧 Examples

```bash
$ ./timer.sh create eggs 15m3s & # it blocks cli
52162: Timer eggs started for duration 15m 3s!
$ ./timer.sh list
PID   Timer Duration Remaining
52162 eggs  15m      15m 2s
$ ./timer.sh countdown eggs # loops until complete
Remaining: 15m 1s
...
Timer eggs completed!
$ ./timer.sh kill eggs # OR using PID `./timer.sh kill 52162`
Timer with task name eggs and PID 52162 killed successfully!
```

---

## 📂 Project Structure

```
timer/
├── timer.sh             # CLI entry point
├── timer_create.sh      # Create a timer
├── timer_kill.sh        # Kill a timer
├── timer_list.sh        # List active timers
├── timer_rofi.sh        # Rofi integration for selecting timers
├── timer_countdown.sh   # Show visual countdown for a timer
├── created.mp3
├── completed.mp3
├── canceled.mp3
```

---

## 🔔 Notifications and Sound

- `notify-send` is used to show desktop notifications
- `mpv` is used to play audio files

Make sure `notify-send` and `mpv` are installed on your system.

---

## ✅ Requirements

- Bash 4+
- `mpv`
- `notify-send`
- `awk`
- `tail`
- `column`
- `dirname`
- `basename`
- `realpath`
- `date`
- `rofi` (optionally)

---

## 📥 Installation

```bash
git clone https://github.com/Davenchy/timer_sh.git
cd timer
chmod +x timer.sh timer_*.sh
```

You can optionally symlink it globally:

```bash
sudo ln -s "$(pwd)/timer.sh" /usr/local/bin/timer
```

OR use `install.sh`:

```bash
chmod +x install.sh
./install.sh
```

Then use it anywhere as:

```bash
timer create Focus 25m
```

---

## 📁 Temporary Files

Timers are stored as temporary `.timer` files in `/tmp`, with format:

```csv
PID:TASK_NAME:DURATION:STARTED_AT
```

Example for `./timer.sh create Focus 25m`:

```csv
69842:Focus:1500:2025-04-05 01:09:49
```

Each timer deletes its own file on completion or cancel.

---

## 🎵 Audio Attribution

The `created` and `completed` audio files are by [Universfield](https://pixabay.com/users/universfield-28281460/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=210334) from [Pixabay](https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=210334).

The `canceled` audio file is by [Rescopic Sound](https://pixabay.com/users/rescopicsound-45188866/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=228338) from [Pixabay](https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=228338).

---

## 📃 License

MIT License. Feel free to fork, modify, and use.

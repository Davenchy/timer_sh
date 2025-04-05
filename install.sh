#!/usr/bin/env bash
# Optionally install the timer command

# Ensure the scripts are executable
chmod +x "./timer_*.sh"

# Link the timer script
sudo ln -s "$(pwd)/timer.sh" "/usr/local/bin/timer"
if [ $? -eq 0 ]; then
  echo "Timer command installed successfully to '/usr/local/bin/timer'!"
else
  echo "Failed to install timer command."
fi

# vsh

## Description
vsh is a script invoked as a prefix that allows positioning and resizing windows across screens. It's ideal if you have multiple monitors and want to launch a program on a different screen. The only dependency is xdotool.

## Syntax

```
vsh x,y,w,h, program_name and parameters
```

## Source

```bash
#!/bin/bash

# Checks if there are at least 5 parameters
if [ "$#" -lt 5 ]; then
  echo "Usage: $0 x y w h program_name"
  exit 1
fi

# Assigns the parameters to variables
x=$1
y=$2
w=$3
h=$4

# Removes the first four parameters; the rest are the command and its parameters
shift 4
program_name="$1"
shift 1

# Launches the program in background and gets the PID
$program_name &
pid=$!

# Waits for a second to give time for the window to open
sleep 1

# Finds the window ID associated with the PID
window_id=$(xdotool search --onlyvisible --pid $pid | tail -n 1)

# Checks if a window ID was found
if [ -z "$window_id" ]; then
  echo "Error: Unable to find the application window."
  exit 1
fi

# Positions and resizes the window
xdotool windowmove "$window_id" "$x" "$y"
xdotool windowsize "$window_id" "$w" "$h"

# Uses wait to prevent the process from becoming a zombie
wait $pid

#echo "Application '$program_name' launched and positioned at ($x, $y) with size (${w}x${h})"
```

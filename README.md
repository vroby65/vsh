# vsh
Description
vsh is a script that acts as a prefix, allowing you to position and resize a window across multiple screens. It is ideal if you have multiple screens and want to launch a program on a different screen. The only dependency is xdotool.

Syntax
Copia codice
vsh x,y,w,h program_name and parameters
Source Code
bash
Copia codice
#!/bin/bash

# Check that there are at least 5 parameters
if [ "$#" -lt 5 ]; then
  echo "Usage: $0 x y w h program_name"
  exit 1
fi

# Assign parameters to variables
x=$1
y=$2
w=$3
h=$4

# Remove the first four parameters; the remaining ones are the command and its arguments
shift 4
program_name="$1"
shift 1

# Launch the program in the background and get its PID
$program_name &
pid=$!

# Pause to allow the window to open
sleep 1

# Find the window ID associated with the PID
window_id=$(xdotool search --onlyvisible --pid $pid | tail -n 1)

# Check if a window ID was found
if [ -z "$window_id" ]; then
  echo "Error: could not find the application window."
  exit 1
fi

# Position and resize the window
xdotool windowmove "$window_id" "$x" "$y"
xdotool windowsize "$window_id" "$w" "$h"

# Use wait to prevent the process from becoming a zombie
wait $pid

#echo "Application '$program_name' launched and positioned at ($x, $y) with size (${w}x${h})"


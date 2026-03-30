#!/bin/bash

if [ "$#" -lt 5 ]; then
    echo "Uso:"
    echo "  $0 x y w h comando [argomenti...]"
    echo "oppure:"
    echo "  $0 x y w h \"comando completo\""
    exit 1
fi

x=$1
y=$2
w=$3
h=$4
shift 4

# Avvia il comando:
# - se resta un solo parametro, lo interpreta come stringa completa
# - altrimenti usa gli argomenti così come sono
if [ "$#" -eq 1 ]; then
    bash -lc "$1" &
else
    "$@" &
fi

pid=$!

# Aspetta che compaia una finestra associata al PID
window_id=""
for i in $(seq 1 50); do
    window_id=$(xdotool search --onlyvisible --pid "$pid" 2>/dev/null | tail -n 1)
    [ -n "$window_id" ] && break
    sleep 0.2
done

if [ -z "$window_id" ]; then
    echo "Errore: non è stato possibile trovare la finestra dell'applicazione."
    wait "$pid" 2>/dev/null
    exit 1
fi

xdotool windowmove "$window_id" "$x" "$y"
xdotool windowsize "$window_id" "$w" "$h"

wait "$pid"

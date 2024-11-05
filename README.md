# vsh
## descrizione
vsh è uno script che si invoca come prefisso e permette di posizionare e ridimensionare la finestra sugli schermi complessivi. 
Ideale se hai piu schermi e vuoi lanciare un programma in uno schermo differente 
L'unica dipendenza è xdotool

## sintassi

```
vsh x,y,w,h, programma e parametri
```

## sorgente

```  bash
#!/bin/bash

# Controlla che ci siano almeno 5 parametri
if [ "$#" -lt 5 ]; then
  echo "Uso: $0 x y w h nome_programma"
  exit 1
fi

# Assegna i parametri a variabili
x=$1
y=$2
w=$3
h=$4

# Rimuove i primi quattro parametri; i restanti sono il comando e i suoi parametri
shift 4
program_name="$1"
shift 1

# Lancia il programma in background e ottieni il PID
$program_name &
pid=$!

# Metti in pausa per dare tempo alla finestra di aprirsi
sleep 1

# Trova il window ID associato al PID
window_id=$(xdotool search --onlyvisible --pid $pid | tail -n 1)

# Controlla se è stato trovato un window ID
if [ -z "$window_id" ]; then
  echo "Errore: non è stato possibile trovare la finestra dell'applicazione."
  exit 1
fi

# Posiziona e ridimensiona la finestra
xdotool windowmove "$window_id" "$x" "$y"
xdotool windowsize "$window_id" "$w" "$h"

# Usa wait per evitare che il processo diventi uno zombie
wait $pid

#echo "Applicazione '$program_name' lanciata e posizionata a ($x, $y) con dimensione (${w}x${h})"

```


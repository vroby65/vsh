# vsh

`vsh` is a small Bash script that launches a graphical application, detects the window associated with the process, and automatically moves/resizes it using `xdotool`.

It is useful when you want programs to always open in the same position and size, for example terminals, browsers, editors, or support tools in a multi-monitor setup.

## What it does

The script:

1. receives window coordinates and size;
2. launches the requested command;
3. waits for a visible window linked to the process PID;
4. moves and resizes the window;
5. waits until the process exits.

## Requirements

- `bash`
- `xdotool`
- a graphical environment compatible with `xdotool`

## Installation

Clone the repository and make the script executable if needed:

```bash
chmod +x vsh
```

On Debian/Ubuntu systems, `xdotool` can be installed with:

```bash
sudo apt install xdotool
```

## Usage

```bash
./vsh x y w h command [arguments...]
```

Or:

```bash
./vsh x y w h "full command"
```

Where:

- `x`: horizontal window position in pixels
- `y`: vertical window position in pixels
- `w`: window width in pixels
- `h`: window height in pixels

## Examples

Launch `xterm` in the top-left corner with a `1280x720` size:

```bash
./vsh 0 0 1280 720 xterm
```

Launch `gnome-terminal` with separate arguments:

```bash
./vsh 100 80 1200 700 gnome-terminal -- bash -lc "htop"
```

Launch a full command as a single string:

```bash
./vsh 1920 0 1280 720 "firefox https://github.com"
```

## Notes

- The script tries to find a visible window associated with the process for about 10 seconds.
- If no window is found, it exits with an error.
- It works best with applications that expose a window directly linked to the launched process.
- In some Wayland setups, behavior may be limited or not work at all, because `xdotool` is primarily designed for X11 environments.

## Output on incorrect usage

If too few parameters are provided, the script shows:

```text
Usage:
  ./vsh x y w h command [arguments...]
or:
  ./vsh x y w h "full command"
```

Note: the current script output is still in Italian.

## Project structure

```text
.
├── vsh
└── README.md
```

## License

No license is currently included in the repository.

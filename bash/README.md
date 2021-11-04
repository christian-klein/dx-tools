### Add to .bashrc:

```
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
```

### Use .multialrc:
```
multitail -cS wps_log /mnt/dx-core-1/logs/WebSphere_Portal/SystemOut.log
```
If using alias file the -cS wps_log is added automatically.

Viewing all logs in one file:
```
$ multitail --mergeall *.log
```
Viewing all merged logs in different colors (except for api*.log) in one window:
```
$ multitail --mergeall -c- -Iw 'api-*.log' 10 -C -Iw 'laravel-*.log' 10 -Iw '/var/log/nginx/*log' 1000 -Iw '/var/log/redis/*.log' 1000 -cs -Iw '/var/l
```

## Multitail Keyboard shortcuts
/ - Search in all windows

Shift + / - Search and highlight in all windows

I - Toggle case sensitivity for searches

b - Scroll back

B - Scroll back in all windows merged into one window

a - add a new window or add another file/program to an existing window

d - Delete a window (or a file/program from a window)

s - Swap the location of 2 windows

e - Enter/edit regular expressions

f - Enter/edit in line filter regexps

c - Set/change colors

v - Toggle vertical split

0...9 - Set a mark in a window so that you can easily see what has changed since the last time you looked

R - Restart a window

Ctrl + v - Select conversion scheme(s)

Ctrl + t - toggle subwindow before lines

Y - Send a signal to a window (for commands)

y - Set linewrap

T - Truncate a logfile

g - Make screendump

r - Redraw screen

l - List keybindings

i - Info

t - Statistics

o - Wipe (clear) a window

O - Wipe all windows

j - Set window sizes

z - Hide/unhide a window

u - Hide all windows but the one selected

U - Unhide all windows

w - Write a script which starts multitail with the current settings (the files that are monitored, regular expressions, etc.)

n - Clear the buffer of a window

N - Clear all buffers of all windows

m - Set the size of a buffer

k - Enter a (limited) terminal-mode

p - Pause all windows

P - (un-)pause one window

q - Quit
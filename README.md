# x-settings
Includes all my Settings

# .Xresources
xterm*background: #000
xterm*foreground: white
xterm*faceName: monospace:pixelsize=14

xterm*vt100.translations: #override \
    Shift Ctrl <Key> C: copy-selection(CLIPBOARD) \n\
    Shift Ctrl <Key> V: insert-selection(CLIPBOARD)

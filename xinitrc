#! /bin/sh

# https://github.com/Gekkio/gnome-session-xmonad
if [ -z $XDG_CURRENT_DESKTOP ]; then
  export XDG_CURRENT_DESKTOP="GNOME-Flashback:Unity"
fi

exec gnome-session --session=gnome-xmonad --disable-acceleration-check "$@"
#exec gnome-session --session xmonad "$@"

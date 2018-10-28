#! /bin/bash
# run florence (virtual keyboard). Requires xhost authentication for local root
DISPLAY=:0
export DISPLAY=:0
PROGNAME="xvkbd"
# PROGNAME="florence"
if [ -z `/usr/bin/pgrep "$PROGNAME"` ]; then
    #zenity --info --text="florence not running. Starting."
    su -c "$PROGNAME" wyatt & disown
else
    #zenity --info --text="florence is running"
    pkill "$PROGNAME"
fi


/usr/bin/true

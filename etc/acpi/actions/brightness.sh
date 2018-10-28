#!/bin/bash
export DISPLAY=:0
#zenity --info --text "hi"
#STEP=66

setbrightness() {
    echo "$1" > /sys/class/backlight/intel_backlight/brightness;
}


# do nothing, acpi or bios (I actually have no idea) is already handling backlight changes just fine.
brightnessup() {
    true
}

# only do something if brightness is at lowest point - in order to disable the backlight altogether.
brightnessdown() {
    # acpi_video0 might also work
#    curbright=`< /sys/class/backlight/intel_backlight/brightness`
#    zenity --info --text "$curbright"
#    if [ "$curbright" -eq 0 ]; then
#        sleep 1 # avoid potential race condition
#        /usr/bin/intel_backlight 0 # turn backlight OFF if already at minimum.
#    fi
    true
}

in="$1";
#zenity --info --text "$1"
inStart="${in%% *}"
inDirection="${inStart#video/brightness}"

case "$inDirection" in
    "up")
        brightnessup
        ;;
    "down")
        brightnessdown
        ;;
esac

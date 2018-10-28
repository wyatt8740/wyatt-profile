#! /bin/sh
# backlight-toggle.sh: a script to turn the backlight on and off on Intel
# backlit systems by using intel_backlight from:
# https://gitlab.freedesktop.org/drm/igt-gpu-tools
# or
# https://cgit.freedesktop.org/xorg/app/intel-gpu-tools/
# Since LVDS-based systems running newer versions of the Linux kernel don't
# allow turning the backlight off independently of the video encoder (at least
# via sysfs), intel_backlight is used to poke the correct register on the GPU
# directly.

# This requires root priveledges - either run as root normally, or you will
# need to change the save directory and make intel_backlight run with suid
# root (which may not be safe as it doesn't sanitize CLI arguments).
#
# When set up to trigger on an ACPI event, it will run as root, so if you can
# find an ACPI event with no response you need (such as 'button/zoom ZOOM' on
# my thinkpad - fn+space), that might be the way to go.
# 
# note - I use a modified version of intel_backlight which works on decimal
# values and prints the current light state in decimal format.
# I use dc here to truncate off the decimal places so it works better
# in bash comparisons. (0.00 vs 0). If you use vanilla dc this is unnecessary.

# for vanilla intel_backlight, the 'export light_state' line can instead read:
# export light_state=$(/usr/bin/intel_backlight | sed 's/current backlight value: //g'|sed 's/%//g')

BRIGHTSAVEFILE="/root/.brightness"
BRIGHTSYSFS="/sys/class/backlight/acpi_video0/brightness"

# is light on or off?
export light_state=$(echo "$(/usr/bin/intel_backlight | sed 's/current backlight value: //g'|sed 's/%//g')"" 0 k 1 / p" | dc)
if [ "$light_state" -eq 0 ]; then
    # restore previous brightness as stored in $BRIGHTSAVEFILE
    cat "$BRIGHTSAVEFILE" > "$BRIGHTSYSFS"
else
    # back up current brightness level
    cat "$BRIGHTSYSFS" > "$BRIGHTSAVEFILE"
    # turn off backlight
    /usr/bin/intel_backlight 0 > /dev/null
fi

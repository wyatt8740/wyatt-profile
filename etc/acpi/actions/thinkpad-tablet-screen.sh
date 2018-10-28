#! /bin/sh
# by Wyatt Ward.
# handles rotating X201 tablet's screen. Requires that root be allowed to
# connect to the X server (either via xauth entries or running
# `xhost +local:root`
#
# when in tablet mode:
#  $1               $2   $3       $4
#  video/tabletmode TBLT 0000008A 00000001
#
# when in laptop mode:
#  $1               $2   $3       $4
#  video/tabletmode TBLT 0000008A 00000000
#
# 00000001 is the same as 1 when using `test` (`[ 00000001 -eq 1 ]`)

# if X is running on :0
DISPLAY=:0
export DISPLAY=:0
#zenity --info --text "$4"

invertscreen() {
    /usr/bin/xrandr --output LVDS1 --rotate inverted
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Finger touch' Rotate half
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Pen stylus' Rotate half
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Pen eraser' Rotate half
    echo "TODO : rotate trackpoint matrix. Now just setting to normal"
    xinput set-prop 'TPPS/2 IBM TrackPoint' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
}

normalscreen() {
    /usr/bin/xrandr --output LVDS1 --rotate normal
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Finger touch' Rotate none
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Pen stylus' Rotate none
    /usr/bin/xsetwacom set 'Wacom Serial Penabled 2FG Touchscreen Pen eraser' Rotate none
    echo "Rotating trackpoint matrix to normal."
    xinput set-prop 'TPPS/2 IBM TrackPoint' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1    
}

export orientation=`/usr/bin/xrandr --verbose -q | grep LVDS | awk '{print $6}'`
printf "$orientation" | grep -q \(
if [ "$?" -eq 0 ]; then
  export orientation=`/usr/bin/xrandr --verbose -q | grep LVDS | awk '{print $5}'`
fi

if [ "$4" -eq 1 ]; then
    # invert screen, lid is in tablet mode
    # (unless in portrait; then do nothing)
    if [ "$orientation" = "normal" ]; then
        invertscreen
    elif [ "$orientation" = "inverted" ]; then
        invertscreen
    fi
    # do nothing if in portrait
        
else # in laptop mode
    if [ "$orientation" = "normal" ]; then
        normalscreen
    elif [ "$orientation" = "inverted" ]; then
        normalscreen
    fi
    # do nothing if in portrait
           
    # restart fvwm
    # geometry doesn't change when just inverting, so no need to restart fvwm.
    #    FvwmCommand 'Restart'
    # don't fail if not using fvwmcommand or fvwm at all
    #    true
fi

# don't fail. Ever. I mean it.
true


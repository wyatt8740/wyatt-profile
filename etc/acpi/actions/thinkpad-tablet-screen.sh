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

#Wacom Serial Penabled 2FG Touchscreen Finger touch
#Wacom Serial Penabled 2FG Touchscreen Pen stylus
#Wacom Serial Penabled 2FG Touchscreen Pen eraser
#
#      |
#     \./
#
#Serial Wacom Tablet WACf00c touch
#Serial Wacom Tablet WACf00c stylus
#Serial Wacom Tablet WACf00c eraser

comptonkill() {
  true
  # sudo -u wyatt /bin/bash -c '/home/wyatt/bin/compton & disown'
}

#put in a function for easy debugging
action_func()
{
  # if [ "$1" = 'video/tabletmode' ]; then
  # if X is running on :0
    if [ -z "$DISPLAY" ]; then
       DISPLAY=:0
       export DISPLAY
    fi
    xsetwacom list devices | sed 's/\t.*//' | awk '{ print $3 }' | grep -q Tablet
    export TABTYPE="$?"
    # 0 if 'Tablet' was found by grep
    if [ "$TABTYPE" -eq 0 ]; then # wacf00c bullshit if third word is tablet
	xsetwacom list devices | grep -q 'WACf00c'
	if [ "$?" -eq 0 ]; then
	    # x201 tablet
            export TABTYPE=0
            export TABLETPREFIX='Serial Wacom Tablet WACf00c '
            export PREFIXPEN=''
            export PREFIXTOUCH=''
	    export HASTOUCH='no'
	else
	    # x61 tablet
            export TABTYPE=0
            export TABLETPREFIX='Serial Wacom Tablet WACf004 '
            export PREFIXPEN=''
            export PREFIXTOUCH=''
	    export HASTOUCH='yes'
	fi
    else
	xsetwacom list devices | grep 'Serial' | grep -q 'Touchscreen'
	if [ "$?" -eq 0 ]; then
	    # x201 tablet (multitouch variant)
            export TABTYPE=1
            export TABLETPREFIX='Wacom Serial Penabled 2FG Touchscreen '
            export PREFIXTOUCH='Finger ' # empty for WACf00c
            export PREFIXPEN='Pen ' #empty for WACf00c
	    export HASTOUCH='yes'
	else
	    # x61 tablet (no touch)
            export TABTYPE=1
            export TABLETPREFIX='Wacom Serial Penabled '
            export PREFIXTOUCH='Finger ' # empty for WACf00c
            export PREFIXPEN='Pen ' #empty for WACf00c
	    export HASTOUCH='no'
	fi
    fi
    #zenity --info --text "$4"

    invertscreen() {
        /usr/bin/xrandr --output LVDS1 --rotate inverted
        comptonkill
        echo "TODO : rotate trackpoint matrix. Now just setting to normal"
        /usr/bin/xinput set-prop 'TPPS/2 IBM TrackPoint' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
#        if [ "$TABTYPE" -eq 0 ]; then
        echo "applying coordinate transformation for stylus to be correct upside-down"
        /usr/bin/xinput set-prop "$TABLETPREFIX""$PREFIXPEN"'stylus' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
        /usr/bin/xinput set-prop "$TABLETPREFIX""$PREFIXPEN"'eraser' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
#        fi
        #    echo "$TABLETPREFIX""$PREFIXPEN"'eraser' > /tmp/blaaaa
        ##    xinput set-prop 'Serial Wacom Tablet WACf00c stylus' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
        ##    xinput set-prop 'Serial Wacom Tablet WACf00c eraser' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    }

    normalscreen() {
        /usr/bin/xrandr --output LVDS1 --rotate normal
        comptonkill

        echo "Rotating trackpoint matrix to normal."
        #    xinput set-prop 'TPPS/2 IBM TrackPoint' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
#        if [ "$TABTYPE" -eq 0 ]; then
        /usr/bin/xinput set-prop "$TABLETPREFIX""$PREFIXPEN"'stylus' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
        /usr/bin/xinput set-prop "$TABLETPREFIX""$PREFIXPEN"'eraser' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
#        fi
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
# elif [ "$1" = 'video/switchmode' ]; then    # if X is running on :0
    # DISPLAY=:0
    # export DISPLAY=:0
    # /usr/bin/xrandr --verbose -q | grep LVDS|grep -q [0-9]x[0-9]
    # if [ "$?" -eq 0 ]; then # LVDS1 output is connected and outputting currently
    #     /usr/bin/xrandr --output LVDS1 --off
    # else
    #     /usr/bin/xrandr --output LVDS1 --auto
    # fi  
    #fi
#          /etc/acpi/actions/move_tray_clock || true
}
# set -x
# action_func "$@" 2>&1 | tee /home/wyatt/log_acpi.txt
# set +x
action_func "$@"
# don't fail. Ever. I mean it.
true


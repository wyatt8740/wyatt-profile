#! /bin/bash

# thinkpad tablet models have no thinklight (sadly). Check this first.
cat /sys/class/dmi/id/product_family | grep -q Tablet
if [ "$?" -eq 0 ]; then
  # we are on a tablet, so don't bother doing anything.
  # (actually, we will make this button just turn off the backlight on such
  # models, just so it's not useless.)

  # intel_backlight appears to require root privs.
  
  # is the light on or off?
  export INTEL_BACKLIGHT="/usr/bin/intel_backlight"
  # cut off decimal places using dc for my modified version of intel_backlight
  export light_state=$(echo "$(/usr/bin/intel_backlight | sed 's/current backlight value: //g'|sed 's/%//g')"" 0 k 1 / p" | dc)
#  export light_state=$("$INTEL_BACKLIGHT" | sed 's/current backlight value: //g'|sed 's/%//g')
  echo "light: ""$light_state"
  if [ "$light_state" -eq 0 ]; then
    cat /root/brightness > /sys/class/backlight/acpi_video0/brightness
  else
    # back up current brightness level
    cat /sys/class/backlight/acpi_video0/brightness > /root/brightness
    # turn off backlight
    "$INTEL_BACKLIGHT" 0
  fi
else
  # we are on a model which likely has a thinklight. So let's toggle it.
  STATE=$(cat /sys/class/leds/tpacpi\:\:thinklight/brightness)
  if [ "$STATE" -gt 0 ]; then
    echo 0 > /sys/class/leds/tpacpi\:\:thinklight/brightness
  else
    echo 255 > /sys/class/leds/tpacpi\:\:thinklight/brightness
  fi
fi

#!/bin/sh

test -f /usr/share/acpi-support/key-constants || exit 0

. /usr/share/acpi-support/power-funcs
. /usr/share/acpi-support/policy-funcs

if { CheckPolicy || CheckUPowerPolicy; }; then
    exit
fi

if `cat /sys/class/power_supply/A*/online | grep -q 1`; then
	pm-powersave false
else
	pm-powersave true
fi

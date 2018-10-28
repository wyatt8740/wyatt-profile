#! /bin/sh
# Do an action on x201 tablet stylus pen insertion/removal

# 

DISPLAY=:0
export DISPLAY=:0

if [ "$4" = "0000500c" ]; then # removed pen
    /usr/bin/true
else # 0000500b - inserted pen
    /usr/bin/true
fi
/usr/bin/true

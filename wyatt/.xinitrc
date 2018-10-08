xmodmap ~/.Xmodmap
# ibus (temporarily broken in debian sid, using SCIM instead for japanese)
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

# SCIM
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE='scim'
export QT_IM_MODULE='scim'
export GTK_OVERLAY_SCROLLING=0
xset -dpms; xset s off
#xhost +local:root


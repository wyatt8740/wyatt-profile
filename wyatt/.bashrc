# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$TERM" != "ibm3161" ]; then
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
else
    PS1="\[$(tput bold)\]"'\u@\h:\w\$ '"\[$(tput sgr0)\]"
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -N'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ibus (temporarily broken in debian sid, using SCIM instead for japanese)
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

# SCIM
export XMODIFIERS='@im=SCIM'
export GT_IM_MODULE='scim'
export QT_IM_MODULE='scim'

# unbreak ls again
export QUOTING_STYLE="literal"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:""$PATH"
fi

# add archlinux program directory (/opt/arch) to end of PATH variable
if [ -d "/opt/arch/bin" ] ; then
    PATH="$PATH"":/opt/arch/bin"
fi

PATH="$PATH:/usr/sbin:/sbin:/usr/local/libexec/webkit2gtk-4.0:/usr/games"

alias wget='wget --content-disposition'
alias grep='grep --color=auto'
alias nano='nano -w -T 2'
alias mplayer='mplayer -vo xv -ao alsa'
alias nestopia='retroarch -L /home/wyatt/.config/retroarch/cores/nestopia_libretro.so'
alias genesisplusgx='retroarch -L /home/wyatt/.config/retroarch/cores/genesis_plus_gx_libretro.so'
alias bsnesretro='retroarch -L /home/wyatt/.config/retroarch/cores/bsnes_performance_libretro.so'
alias pc98='retroarch --libretro ~/.config/retroarch/cores/nekop2_libretro.so'
alias n64='retroarch --libretro ~/.config/retroarch/cores/parallel_n64_libretro.so'
alias mupen64='retroarch --libretro ~/.config/retroarch/cores/parallel_n64_libretro.so'
alias np2='retroarch --libretro ~/.config/retroarch/cores/nekop2_libretro.so'
alias desmume_libretro='retroarch -L /home/wyatt/.config/retroarch/cores/desmume_libretro.so'
alias fbi='fbi -autodown'
alias zhcon='zhcon --utf8'
alias netsurf-gtk='netsurf-gtk --cookie_file=/home/wyatt/.config/netsurf/cookies-1.txt --cookie_jar=/home/wyatt/.config/netsurf/cookies-1.txt'
alias netsurf='netsurf-gtk --cookie_file=/home/wyatt/.config/netsurf/cookies-1.txt --cookie_jar=/home/wyatt/.config/netsurf/cookies-1.txt'
alias blankscreens='xset dpms force off'
alias x11vnc='x11vnc -nopw -repeat -nomodtweak'
alias vncviewer='/usr/bin/vncviewer -NoJpeg -QualityLevel 9 -CompressLevel 2 -FullColor -FullScreenSystemKeys'

xclock()
{
    LC_ALL=C /bin/xclock -d -brief -norender -padding 2 "$@"
}

mplayerfb()
{
  2>/dev/null mplayer -vo fbdev2 -vf format=rgb24,scale "$@" > /dev/null
}

mplayer_gif()
{
  FILENAME="$1"
  shift 1
  ffmpeg -stream_loop -1 -i "$FILENAME" -vcodec v308 -f nut - | mplayer "$@" -
}

mplayer_img()
{
  FILENAME="$1"
  shift 1
  ffmpeg -loop 1 -r 2 -i "$FILENAME" -r 2 -vcodec v308 -f nut - | mplayer "$@" -
}

mplayerfb_gif()
{
  FILENAME="$1"
  shift 1
  2>/dev/null ffmpeg -stream_loop -1 -i "$FILENAME" -vcodec v308 -f nut - | mplayerfb "$@" - > /dev/null
}

mplayerfb_img()
{
  FILENAME="$1"
  shift 1
  2>/dev/null ffmpeg -loop 1 -r 2 -i "$FILENAME" -r 2 -vcodec v308 -f nut - | mplayerfb "$@" - > /dev/null
}

autotitle()
{
  # setting $TITLE_OVERRIDE to a non-empty value will allow overwriting the
  # window title with a custom setting.
  if [ -z "$TITLE_OVERRIDE" ]; then
      case "$TERM" in
        *xterm*)
          echo -ne "\033]0;""$@""\007"
          ;;
        *)
          # do nothing if not in an xterm-like terminal
          ;;
      esac
  fi
}

title()
{
  export TITLE_OVERRIDE="1"
  case "$TERM" in
    *xterm*)
    echo -ne "\033]0;""$@""\007"
    ;;
    *)
      # do nothing if not in an xterm-like terminal
    ;;
  esac
}

untitle() # revert to automatic window titles
{
  export TITLE_OVERRIDE="" # null out in case unsetting doesn't export.
  unset TITLE_OVERRIDE
}

export EDITOR='emacs -nw'

# history append
# export PROMPT_COMMAND='history -a'
# history append, also set title to current directory name
case "$TERM" in
  *xterm*)
    export PROMPT_COMMAND='history -a; autotitle "$TERM"": ""$(echo "$PWD" | sed "s!^'"$HOME"'!~!g")"'
    ;;
  *)
    # for non-xterm terminal types, do not set a title.
    export PROMPT_COMMAND='history -a'
    ;;
esac

#echo "$PWD" | sed 's!^'"$HOME"'!~!g'

# color prompt
if [ "$TERM" = "ibm3161" ]; then
  export PS1="\[$(tput bold)\]"'\u@\h:\w\$ '"\[$(tput sgr0)\]"
else
  export PS1='\[\e[00;32m\]\u@\h\[\e[0m\]:\[\e[00;34m\]\w\[\e[0m\]\$ '
fi

# AT&T AST programs
if [ -d "/home/wyatt/development/att/ast/arch/linux.i386-64/bin" ] ; then
  PATH="$PATH"":/home/wyatt/development/att/ast/arch/linux.i386-64/bin"
fi
if [ -d "/home/wyatt/development/att/ast/arch/linux.i386-64/lib" ] ; then
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"":/home/wyatt/development/att/ast/arch/linux.i386-64/lib"
fi

# Arch
if [ -d "/opt/arch/lib" ] ; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH"":/opt/arch/lib"
fi

# prepend ld.so.conf stuff so I don't break linking
export LD_LIBRARY_PATH="/usr/local/lib:/usr/local/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:""$LD_LIBRARY_PATH"

#export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.crossplatformlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel -Dawt.useSystemAAFontSettings=lcd'

alias java='/home/wyatt/bin/java -Dawt.useSystemAAFontSettings=lcd'

alias update-my-alternatives='update-alternatives --altdir ~/.local/etc/alternatives --admindir ~/.local/var/lib/alternatives'
export GTK_OVERLAY_SCROLLING=0

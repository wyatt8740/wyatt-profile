# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

PATH="$PATH:/usr/sbin:/sbin:/usr/local/libexec/webkit2gtk-4.0"

# unbreak ls again
export QUOTING_STYLE="literal"

#alias java='java -Dawt.useSystemAAFontSettings=lcd -Dswing.crossplatformlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel'
alias wget='wget --content-disposition'
alias grep='grep --color=auto'
alias nano='nano -w -T 2'
alias mplayer='mplayer -vo xv -ao alsa'
alias nestopia='retroarch -L /home/wyatt/.config/retroarch/cores/nestopia_libretro.so'
alias genesisplusgx='retroarch -L /home/wyatt/.config/retroarch/cores/genesis_plus_gx_libretro.so'
alias bsnes='retroarch -L /home/wyatt/.config/retroarch/cores/bsnes_performance_libretro.so'
alias pc98='retroarch --libretro ~/.config/retroarch/cores/nekop2_libretro.so'
alias n64='retroarch --libretro ~/.config/retroarch/cores/parallel_n64_libretro.so'
alias mupen64='retroarch --libretro ~/.config/retroarch/cores/parallel_n64_libretro.so'
alias np2='retroarch --libretro ~/.config/retroarch/cores/nekop2_libretro.so'
alias ls='ls --color=auto -N'
#alias renamesortdate='renamesortdate 2>&1 > /dev/null'
alias timidity='timidity -Os -iA'
alias sl='sl -e'
alias fbi='fbi -autodown'
alias zhcon='zhcon --utf8'
alias blankscreens='xset dpms force off'
# allow key repetition, don't require password
alias x11vnc='x11vnc -nopw -repeat -nomodtweak'


xclock()
{
    LC_ALL=C /bin/xclock -d -brief -norender -padding 2 "$@"
}


export EDITOR='nano -w'

export PROMPT_COMMAND='history -a'

# AT&T AST programs
PATH="$PATH:/home/wyatt/development/att/ast/arch/linux.i386-64/bin"
export LD_LIBRARY_PATH="/home/wyatt/development/att/ast/arch/linux.i386-64/lib"

# dash PS1 var
if [ "$BASH_VERSION" = '' ]; then
	if [ "$SHELL" = '/bin/bash' ]; then
		# actually running dash probably
		export PS1="$USER""@""$HOSTNAME"":""$PWD""\$ "
	elif [ "$SHELL" = '/usr/bin/dash' ]; then
		export PS1="$USER""@""$HOSTNAME"":""$PWD""\$ "
	elif [ "$SHELL" = 'bash' ]; then
		export PS1="$USER""@""$HOSTNAME"":""$PWD""\$ "
	elif [ "$SHELL" = '/bin/bash' ]; then
		export PS1="$USER""@""$HOSTNAME"":""$PWD""\$ "
	elif [ "$SHELL" = 'dash' ]; then
		export PS1="$USER""@""$HOSTNAME"":""$PWD""\$ "
	fi
fi

#export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.crossplatformlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel -Dawt.useSystemAAFontSettings=lcd'
alias java='/home/wyatt/bin/java -Dawt.useSystemAAFontSettings=lcd'
export GTK_OVERLAY_SCROLLING=0

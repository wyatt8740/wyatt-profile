PS1='$(print -n "`logname`@`hostname`:";if [[ "${PWD#$HOME}" != "$PWD" ]] then; print -n "~${PWD#$HOME}"; else; print -n "$PWD";fi;print "$ ")'
export SHELL=/home/wyatt/bin/ksh93

set -o emacs
alias __A=`echo "\020"`     # up arrow = ^p = back a command
alias __B=`echo "\016"`     # down arrow = ^n = down a command
alias __C=`echo "\006"`     # right arrow = ^f = forward a character
alias __D=`echo "\002"`     # left arrow = ^b = back a character
alias __H=`echo "\001"`     # home = ^a = start of line
alias __Y=`echo "\005"`     # end = ^e = end of line

xclock()
{
    LC_ALL=C /bin/xclock -d -brief -norender -padding 2 "$@"
}
#alias java='java -Dawt.useSystemAAFontSettings=lcd -Dswing.crossplatformlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel'
export JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.crossplatformlaf=com.sun.java.swing.plaf.motif.MotifLookAndFeel -Dawt.useSystemAAFontSettings=lcd'

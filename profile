echo "SH Profile"

export FCEDIT=/usr/bin/vi
if which oni > /dev/null; then
  export EDITOR=$(which oni)
  export VISUAL=$(which oni)
elif which vim > /dev/null; then
  export EDITOR=$(which vim)
  export VISUAL=$(which vim)
else
  export EDITOR=$(which vi)
  export VISUAL=$(which vi)
fi

#HISTFILE=
export HISTSIZE=32786
#HOME=
export LANG=en_US.UTF-8
#LC_ALL
#LC_COLLATE=
#LC_CTYPE=
#LC_MESSAGES=
#LC_MONETARY=
#LC_NUMERIC=
#LC_TIME=
#MAIL=
#MAILCHECK=
#MAILPATH=
#NLSPATH=
#PATH=
if [ -x /usr/libexec/path_helper ]; then
	PATH=""
	eval `/usr/libexec/path_helper -s`
fi
export PATH

if [ -f ~/.prompt ]; then
	source ~/.prompt
else
	export PS1="\u@\h in \W \n\$ "
	#export PS2="> "
	export PS3=": "
	#export PS4="+ "
fi

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export GREP_OPTIONS='--colour=auto'

# set default options for 'ls'
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# set default options for 'less'
export LESS='-F -i -J -M -R -x4 -s -z-4'
export LESSCHARSET=utf-8
# Set colors for less.
export LESS_TERMCAP_mb=$(tput blink)              # begin blink
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # begin bold
export LESS_TERMCAP_me=$(tput sgr0)               # reset bold/blink
export LESS_TERMCAP_so=$(tput smso)               # begin reverse video
export LESS_TERMCAP_se=$(tput rmso)               # reset reverse video
export LESS_TERMCAP_us=$(tput smul; tput setaf 2) # begin underline
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)    # reset underline



export JAVA_HOME=$(/usr/libexec/java_home -v )
if which go > /dev/null; then
	export GOPATH=$(go env GOPATH)
	export GOROOT=$(go env GOROOT)
	export GOBIN=$(go env GOBIN)
	export GOTMPDIR=$(go env GOTMPDIR)
fi

####
#set -o vi	# enable vi-mode editinga

echo "End SH Profile"

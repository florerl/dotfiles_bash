# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f $HOME/.profile ]; then source $HOME/.profile; fi

echo "Bash Profile"

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

echo "End Bash Profile"

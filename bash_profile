# If not running interactively, don't do anything
[ -z "$PS1" ] && return
echo "Bash Profile"

if [ -f $HOME/.profile ]; then source $HOME/.profile; fi


if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

echo "End Bash Profile"

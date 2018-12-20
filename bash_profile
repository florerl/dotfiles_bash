# If not running interactively, don't do anything
[ -z "$PS1" ] && return
echo "Bash Profile"

if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

echo "End Bash Profile"

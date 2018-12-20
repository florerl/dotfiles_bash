# If not running interactively, don't do anything
if [[ $- != *i* ]] ; then return fi  # Shell is non-interactive.  Be done now!

echo "Bash Profile"
if [[ -f $HOME/.bashrc ]] ; then source $HOME/.bashrc; fi
echo "End Bash Profile"

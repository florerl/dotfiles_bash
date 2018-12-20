### Start of universal section ###
# Commands in this section will be executed by both interactive and
# non-interactive shells.
# Commands here must produce no output, or they will break commands
# like scp and rsync.

if [ -r /etc/bashrc ]; then source /etc/bashrc;
elif [ -r /etc/bash.bashrc ]; then source /etc/bash.bashrc; fi

if [ -r $HOME/.profile ]; then source $HOME/.profile; fi


### End of universal section ###
if [[ $- != *i* ]] ; then return fi  # Shell is non-interactive.  Be done now!


### Start of interactive section ###
# set default options for 'bash/GNU'
export HISTCONTROL='ignoreboth'
export HISTTIMEFORMAT='%F %T'
export TIMEFORMAT= $'\nreal\t%lR\tuser\t%lU\tsys%lS'



# Commands in this section will be executed only by interactive shells.

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell;

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null



# Use Bash completion, if installed
#if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then source "$(brew --prefix)/share/bash-completion/bash_completion";
if [ -r /etc/bash_completion ]; then source /etc/bash_completion; fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "${HOME}/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;



# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.
# We run dircolors directly due to its changes in file syntax and
# terminal name patching.

if type -P dircolors >/dev/null ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	LS_COLORS=
	if [[ -f ~/.dir_colors ]] ; then
		eval "$(dircolors -b ~/.dir_colors)"
	elif [[ -f /etc/DIR_COLORS ]] ; then
		eval "$(dircolors -b /etc/DIR_COLORS)"
	else
		eval "$(dircolors -b)"
	fi
	# Note: We always evaluate the LS_COLORS setting even when it's the
	# default.  If it isn't set, then `ls` will only colorize by default
	# based on file attributes and ignore extensions (even the compiled
	# in defaults of dircolors). #583814
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
	else
		# Delete it if it's empty as it's useless in that case.
		unset LS_COLORS
	fi
else
	# Some systems (e.g. BSD & embedded) don't typically come with
	# dircolors so we need to hardcode some terminals in here.
	case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) use_color=true;;
	esac
fi

if ${use_color} ; then
	#BSD#@export CLICOLOR=1
	#GNU#@alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
fi

for file in $HOME/.{aliases,functions,,completion}; do
    [[ -r "$file" ]] && source "$file"
done

if [[ $(uname) == Darwin ]]; then 
	for file in $HOME/.{bash,aliases}.macos; do 
		[[ -r $file ]] && source $file; done; fi

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -r ~/.localrc ]]; then source ~/.localrc; fi

# Try to keep environment pollution down, EPA loves us.
unset file use_color color_prompt

### End of interactive section ###




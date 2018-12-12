### Start of universal section ###
# Commands in this section will be executed by both interactive and
# non-interactive shells.
# Commands here must produce no output, or they will break commands
# like scp and rsync.

HOST=$(hostname -s)

### End of universal section ###

[ -z "$PS1" ] && return

### Start of interactive section ###
# Commands in this section will be executed only by interactive shells.

### End of interactive section ###

# shortcut to this dotfiles path is $ZSH
#export ZSH=$HOME/.dotfiles

# your project folder that we can `c [tab]` to
#export PROJECTS=~/Code

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# all of our zsh files
#typeset -U config_files
#config_files=($ZSH/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

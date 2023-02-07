#  
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

[[ "$(whoami)" = "root" ]] && return 

## source .bash_env and/or bash_aliases. .bash_prompt if exist
#
[[ -f ~/.bash_env ]] && . ~/.bash_env
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bash_prompt ]] && . ~/.bash_prompt
#for file in ~/.bash_{prompt,env,aliases}; do
#   source "$file"
#done

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100   

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

##  avoid saving consecutive identical commands, and commands that start with a space
## rcnt mod
export HISTCONTROL=ignoreboth

## to use fzf bash completion
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash
## to use fzf-tab-completion pkg in Aur in conjunction with fzf
source /usr/share/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# auto cd 
shopt -s autocd;

# include autocompletions with. filenames
# # recent mods
shopt -s dotglob;

## dir expand and dirspell
## recent mod
shopt -s direxpand;
shopt -s dirspell;

## if command not found in bash terminal, search pacman database for program providing command
source /usr/share/doc/pkgfile/command-not-found.bash


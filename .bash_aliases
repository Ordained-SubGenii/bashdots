#!/bin/false   
# shellcheck shell=bash   
# /bin/false added to allow only sourcing (not executing) file ~/.bash_aliases
# sourced by ~/.bashrc to load all user defined aliases & functions
#

#### Functions #########################################
EC() {
        # Display error codes of last command run on cli
        echo -e "\e[1;33m'code $?'\e[m\n"
}
trap EC ERR

_CheckInternetConnection() {
    if ping -c 1 example.org >/dev/null; then printf "You Appear Connected to Al Gore\n"; else printf "Hmm, where is Gore?\n"; fi
}

## Arch aspecific functions

UpdateArchPackages() {
    # Updates Arch packages
    local updates
    updates="$(checkupdates)"
    if [[ "$updates" != "" ]] ; then
        sudo pacman -Syu 
        return 0
    else
        printf "No arch upstream updates. \n"
        return 1
    fi
}

UpdateAURPackages() {
    # Check for Aur package wrappper and update AUR packages
if type -P paru &>/dev/null; then
	# paru wrapper 
	if paru -Qua; then 
        	paru -Sua
    	else
        	printf "No AUR updates. \n"
    	fi
elif 
    # yay wrapper    
    type -P yay &>/dev/null; then
	local aurupdates
    	aurupdates="$(yay -Qua)"
	if [[ "$aurupdates" != "" ]]; then
	   	yay -Syua
	else 
		printf "No Aur Updates. \n"
	fi
else 
    { printf "neither paru nor yay AUR wrappers detected. not updating AUR packages \n"; return 1; }
fi

}

UpdateAllPackages() {
    # Updates all packages in the system.
    # Upstream (i.e. Arch) packages are updated first.
    # If there are Arch updates, you should run
    # this function a second time to update
    # the AUR packages too.

    UpdateArchPackages || UpdateAURPackages
}


## Some generally useful functions by EndeavourOS install.
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

ShowInstallerIsoInfo() {
    local file
    file="/usr/lib/endeavouros-release"
    if [ -r "$file" ] ; then
        cat "$file"
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}

#### Aliases #######################################
alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."
alias pacup=UpdateAllPackages
alias lla='ls -la --color=auto'
alias rm='rm -i'
alias sudo='sudo -v; sudo '  #refresh timeout before new command and allow sudo use with user functions/aliases 
alias checkinternet=_CheckInternetConnection
alias rsync='$HOME/bin/rsync_notrails'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias lsblki='lsblk -o NAME,PATH,LABEL,PARTLABEL'
alias dgit='git --git-dir=$HOME/.llamadacasa/.git --work-tree=$HOME'
alias xla='exa -la'
alias arbol='exa -T'
alias nvim='lvim'
alias havin='pacman -Qs'

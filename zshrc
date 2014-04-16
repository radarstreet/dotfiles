# vim: set nospell:

# This is for powerline
#export PYTHONPATH=/usr/lib/python3.3/site-packages
#PATH=/usr/share/eclipse:$PATH
PATH=/home/radarstreet/bin:$PATH
##############################################################################
# History settings
##############################################################################
# location of history file
export HISTFILE=$HOME/.histfile
# number of lines to keep in history
export HISTSIZE=1000
# number of lines saved in history after logout
export SAVEHIST=1000
# A useful trick to prevent particular entries from being recorded into a history by preceding them with at least one space.
setopt hist_ignore_all_dups
# Other History Options
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

export EDITOR=vim
GPG_TTY=`tty`
export GPG_TTY

##############################################################################
# Autocompletion 
##############################################################################
# Enable Autocompletion
autoload -U compinit
compinit

# Enable autocompletion menu
zstyle ':completion:*' menu select

# Autocompletion of command line switches
setopt completealiases

##############################################################################
# Prompt
##############################################################################
autoload -U promptinit
promptinit

##############################################################################
# Keybindings
##############################################################################
# enable vi like mode
bindkey -v

function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
	RPS2=$RPS1
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' ${terminfo[smkx]}
	}

	function zle-line-finish () {
		printf '%s' ${terminfo[rmkx]}
	}

	zle -N zle-line-init
	zle -N zle-line-finish
fi
##############################################################################
# Aliases
##############################################################################

# set up ls aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# set up grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

##############################################################################
# PROMPT
##############################################################################

autoload -U colors && colors
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%# "
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"
#. /usr/share/zsh/site-contrib/powerline.zsh

#export PAGER=/usr/bin/vimpager
#alias less=$PAGER 
#alias zless=$PAGER

alias ..='cd ..'
#xrdb .Xresources


##############################################################################
# Directory Navigation
##############################################################################

# Change directories by simply typing directory name (no cd required)
setopt AUTO_CD
# Automatically push to directory stack when changing directories.
setopt AUTO_PUSHD
# And make pushd work silently
setopt PUSHD_SILENT


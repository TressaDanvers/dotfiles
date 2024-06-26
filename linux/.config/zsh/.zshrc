#!/bin/zsh

## interactive shells only
case $- in
	*i*) ;;
	*) return ;;
esac

## zsh
zstyle ':completion:*' menu select

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U -z compinit && compinit
zmodload -i zsh/complist

# keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# prompt
. $XDG_CONFIG_HOME/zsh/prompt.sh

## history
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$XDG_CACHE_HOME/shell-history

## color
alias grep='grep --color=auto'

noglob alias ls="ls --ignore='\$??*' --color=tty --group-directories-first"
eval $(dircolors -b $XDG_CONFIG_HOME/dircolors)

if ! [ "$(which neofetch)" = "" ]; then alias neofetch="neofetch --ascii_colors 2 15 --colors 15 2 2 2 15"; fi

if [ -f $XDG_CACHE_HOME/wal/sequences ]; then (cat $XDG_CACHE_HOME/wal/sequences &); fi
if [ -f $XDG_CACHE_HOME/wal/colors-tty.sh ]; then . $XDG_CACHE_HOME/wal/colors-tty.sh; fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## alias
alias la='ls -a'
alias ll='ls -l'
alias l='ls -CF'

alias dash='rlwrap dash'

if ! [ "$(which tree)" = "" ]; then alias tre2="tree -L 2"; fi

if ! [ "$(which sudo)" = "" ]; then alias sudo="sudo "; fi
if ! [ "$(which nala)" = "" ]; then alias apt="nala"; fi
alias xsudo='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'

## tmux
if ! [ "$(which tmux)" = "" ]; then
	alias tkill="tmux kill-session -t"

	alias topen="tmux attach-session -t"
	alias tnew="tmux new-session -s"

	# tmux in new window
	case $TERM in
	  *-kitty) alias topen+='kitty --detach tmux attach-session -t' ;;
	  *) alias topen+='gnome-terminal -- tmux attach-session -t' ;;
	esac
fi

function tnew+() {
	if tnew $1 -d; then topen+ $1; fi
}

if [ "$(which tmux)" = "" ]; then unset -f tnew+; fi

## zoxide
if ! [ "$(which zoxide)" = "" ]; then
  eval "$(zoxide init zsh)"
  alias cd=z
  alias cdi=zi
fi

## atuin
if ! [ "$(which atuin)" = "" ]; then
  eval "$(atuin init zsh)"
fi

## chezmoi
if ! [ "$(which chezmoi)" = "" ]; then
  eval "$(chezmoi completion zsh)"
fi

## command-not-found
command_not_found_handler() {
  command-not-found $1
  return 127
}
if [ "$(which command-not-found)" = "" ]; then unset -f command_not_found_handler; fi

## lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Sourced during interactive sessions

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# Reboot directly to Windows
# Inspired by http://askubuntu.com/questions/18170/how-to-reboot-into-windows-from-ubuntu
reboot_to_windows ()
{
    windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
alias reboot-to-windows='reboot_to_windows'

export EDITOR=nvim

# Force screen to use a login shell
alias screen="screen -l"

alias vi=nvim
alias vim=nvim
alias ls='ls --color'

#  Set prompt
autoload -U colors && colors
if [ -n "$TMUX" ]
then 
  LEVEL=$((SHLVL-1))
  THRESHOLD=3
else
  LEVEL=$((SHLVL))
  THRESHOLD=2
fi
NEWLINE=$'\n'
PS1="%$THRESHOLD(L.%{$fg[red]%}[$LEVEL] .)%{$fg[green]%}[%*] %{$fg[cyan]%}[%n@%m:%~]%{$reset_color%}$NEWLINE$ "

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Load some OS installed plugins
function load-plugin()
{
  [ -f $1 ] && source $1
}
load-plugin /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
load-plugin /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


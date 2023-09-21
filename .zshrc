
#Plugins
export ZSH="$HOME/.oh-my-zsh"
plugins=(git colored-man-pages gradle vi-mode)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/dotfiles/starship.toml
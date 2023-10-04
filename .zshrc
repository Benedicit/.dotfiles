
#Plugins
export ZSH="$HOME/.oh-my-zsh"
plugins=(git colored-man-pages gradle vi-mode chucknorris autojump rand-quote)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/dotfiles/starship.toml

#Alias
alias ls='eza --oneline --icons'
alias ll='eza --long --icons'
alias la='eza --long --icons --all'
alias li='eza --all'
alias con='ssh weisb@lxhalle.in.tum.de'
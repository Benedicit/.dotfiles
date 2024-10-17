# Set special paths
export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
export ZSH="$HOME/.oh-my-zsh"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Path for Ocaml Setup
eval $(opam env)

# Setting PATH for Python 3.12
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

export PATH=$PATH:/Users/benedikt/Documents/Programmieren/JavaLibraries/apache-maven-3.9.6/bin
export PATH=$PATH:/Applications/ArmGNUToolchain/13.2.Rel1/arm-none-eabi/bin/
export PATH=$PATH:/opt/homebrew/bin/gcc-14
export PATH=$PATH:/opt/homebrew/opt/llvm/bin

# Plugins
plugins=(git colored-man-pages gradle vi-mode chucknorris autojump rand-quote)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/dotfiles/starship.toml
#Alias
alias ls='eza --oneline --icons'
alias ll='eza --long --icons'
alias la='eza --long --icons --all'
alias li='eza --all'
alias lrz='ssh $LXHALLE' # This environment variable needs to be defined locally
alias code='codium'
alias gb='./gradlew build'
alias gbz='./gradlew buildZip'
alias gbp='./gradlew generateProto'
alias gcc='gcc-14'
alias py='python3'
alias tl='tldr'
alias dotvim='cd ~/dotfiles/.config/nvim'
alias db='dune build'

# Conda setup
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

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

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
eval "$(ssh-agent -s)"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
alias get_include='~/helper_scripts/get_include_paths_from_tasking.sh'
fi

# Plugins
plugins=(git colored-man-pages gradle vi-mode chucknorris autojump rand-quote)
source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.dotfiles/starship.toml
#Alias
alias ls='eza --oneline --icons'
alias ll='eza --long --icons'
alias la='eza --long --icons --all'
alias li='eza --all'
alias ...='cd ../..'
alias lrz='ssh $LXHALLE' # This environment variable needs to be defined locally
alias code='codium'
alias lg='lazygit'
alias gb='./gradlew build'
alias gbz='./gradlew buildZip'
alias gbp='./gradlew generateProto'
alias gcc='gcc-14'
alias g++='g++-14'
alias py='python3'
alias python='python3'
alias tl='tldr'
alias dotvim='cd ~/.dotfiles/.config/nvim'
alias db='dune build'
alias linux='docker start linux && docker attach linux'
alias sld='docker stop linux'
alias pypdf='jupyter nbconvert --to pdf'
alias warrpi='ssh $WARRPI'


export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


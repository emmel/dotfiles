# get the current platform
unamestr=`uname`

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# zsh theme
ZSH_THEME="agnoster"

# oh-my-zsh plugins
plugins=(git docker git-flow golang lein npm python rsync screen sublime
    tmux vagrant z)

if [[ "$unamestr" == 'Darwin' ]]; then
    plugins+=(brew brew-cask osx)
fi

alias emacs="TERM=xterm-16color emacs -nw"

# Set up PATH
if [[ "$unamestr" == 'Darwin' ]]; then
    export PATH=$PATH:/opt/vertica/bin
fi




source $ZSH/oh-my-zsh.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# get the current platform
unamestr=`uname`

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# zsh theme
ZSH_THEME="agnoster"

# oh-my-zsh plugins
plugins=(git docker emacs git-flow golang lein npm python rsync screen sublime
    tmux vagrant z)

if [[ "$unamestr" == 'Darwin' ]]; then 
    plugins+=(brew brew-cask osx)
fi


source $ZSH/oh-my-zsh.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Set up PATH
if [[ $PLATFORM == 'osx' ]]; then
    export PATH=$PATH:/opt/vertica/bin
fi

# homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
nfpath=($HOME/.homesick/repos/homeshick/completions $fpath)

bindkey "\e[3~" delete-char

source $ZDOTDIR/theme.zsh
source $ZDOTDIR/aliases.zsh

if [[ -a "$HOME/.cygwin" ]]; then
    source ~/.cygwin
fi

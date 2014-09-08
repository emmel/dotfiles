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

# Set up completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

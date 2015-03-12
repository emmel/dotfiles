# Emacs
EMACS=`which emacs`
alias emacsd="TERM=xterm-16color $EMACS --daemon"
alias emacs="TERM=xterm-16color emacsclient -nw"

# ls
alias ls='ls -G'
alias lsa='ls -alh'

# git
alias gs='git status'
alias gl='git log --graph --decorate --date=relative --all --oneline --abbrev-commit'


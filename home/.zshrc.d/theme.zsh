write_segment(){
    if [ $# -eq 3 ]; then
        if [[ -n $BG ]]; then
            RPROMPT="%F{$2}%K{$3}$1%F{$BG}%K{$3}%f%k$RPROMPT"
        else
            RPROMPT="%F{$2}%K{$3}$1%f%k$RPROMPT"
        fi
        BG=$3
    fi
}

parse_git_status(){
    local bg s
    typeset -A symbols
    IFS=''
    if [[ -n $vcs_info_msg_0_ ]]; then
        git status --porcelain --ignore-submodules | while read i
        do
            [ "${i:0:1}" = "?" ] && symbols[1]="+"
            [ "${i:0:1}" = " " ] && symbols[2]="☐"
            [[ "${i:0:1}" =~ "[^ ?]" ]] && symbols[3]="☑"
        done

        [[ -n $symbols ]] && bg=yellow || bg=green

        IFS=' '
        s="${symbols[@]}"
        write_segment "$s $vcs_info_msg_0_ " white $bg
    fi
}

end_rprompt() {
    if [[ -n $BG ]]; then
       RPROMPT="%F{$BG}%f$RPROMPT"
    fi
}

build_rprompt() {
    BG=''
    vcs_info
    parse_git_status
    end_rprompt
}

autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%b"
# zstyle ':vcs_info:*' check-for-changes false
#zstyle ':vcs_info:git*' formats '%b'
#zstyle ':vcs_info:git*' actionformats '%b (%a)'
precmd() {
    RPROMPT=''
    build_rprompt
}

autoload -U colors && colors
PROMPT="%F{blue}%~ %(?,%F{cyan},%F{red})❯%f "
setopt prompt_subst

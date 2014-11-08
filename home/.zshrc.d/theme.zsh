write_segment(){
    if [ $# -eq 3 ]; then
        if [[ -n $BG ]]; then
            NEW_RPROMPT="%F{$2}%K{$3}$1%F{$BG}%K{$3}%f%k$NEW_RPROMPT"
        else
            NEW_RPROMPT="%F{$2}%K{$3}$1%f%k$NEW_RPROMPT"
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
       NEW_RPROMPT="%F{$BG}%f$NEW_RPROMPT"
    fi

    if [[ -n $FIRST_BG ]]; then
        NEW_RPROMPT="$NEW_RPROMPT%F{8}%K{$FIRST_BG}%f%k"
    fi
}

vi_mode_indicator() {
    case ${KEYMAP} in
        (vicmd) vi_mode=("'N '" white red) ;;
        (main|viins) vi_mode=("'I '" white cyan) ;;
        (*) vi_mode=("'U '" white yellow) ;;
    esac

    FIRST_BG=$vi_mode[3]
}

function zle-keymap-select {
    prep_rprompt
    vi_mode_indicator
    write_rprompt
    zle reset-prompt
}

function zle-line-init() {
    zle -K viins
}

zle -N zle-line-init
zle -N zle-keymap-select

prep_rprompt() {
    NEW_RPROMPT=''
    BG=''
}

write_rprompt() {
#    vcs_info
#    parse_git_status
    eval "write_segment $vi_mode"
    end_rprompt
    RPROMPT=$NEW_RPROMPT
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%b"
# zstyle ':vcs_info:*' check-for-changes false
#zstyle ':vcs_info:git*' formats '%b'
#zstyle ':vcs_info:git*' actionformats '%b (%a)'
precmd() {
    prep_rprompt
    write_rprompt
}

autoload -U colors && colors
PROMPT="%F{blue}%~ %(?,%F{cyan},%F{red})❯%f "
setopt prompt_subst

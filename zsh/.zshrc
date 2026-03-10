autoload -z compinit && compinit
# non-case-sensetive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={a-z}'


# git module
autoload -z vcs_info
setopt prompt_subst

# vcs_info style
if [[ "$TERM" == "linux" ]]; then
    zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
    zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
    
    PROMPT_SYMBOL=">>>"
    USER_SEP=":"
else
    zstyle ':vcs_info:*' stagedstr '%F{green}✚%f'
    zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
    
    PROMPT_SYMBOL="❯❯❯"
    USER_SEP=":"
fi

zstyle ':vcs_info:git*' formats " %F{blue}%b%f %u%c"
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true

# git status func
precmd() {
    vcs_info
}

# prompt
# %b%~%b - bold font
# ${vcs_info_msg_0_} - git
# %(!.#.$) - first symbol ($ or # for root)
prompt="${PROMPT_SYMBOL} %B%n%b %F{cyan}${USER_SEP}%f %B%~%b\${vcs_info_msg_0_}
%b%(!.#.$)%b "

export PATH="$HOME/bin:$PATH"

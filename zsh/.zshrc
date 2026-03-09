autoload -Uz compinit && compinit
# non-case-sensetive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


# git module
autoload -Uz vcs_info
setopt prompt_subst

# vcs_info style
zstyle ':vcs_info:git*' formats "%F{blue}%b%f %m%u%c %a"
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr ' %F{green}✚%f'
zstyle ':vcs_info:*' unstagedstr ' %F{red}●%f'

# git status func
precmd() {
    vcs_info
}

# prompt
# %B%~%b - bold font
# ${vcs_info_msg_0_} - git
# %(!.#.$) - first symbol ($ or # for root)
PROMPT='❯❯❯ %B%~%b ${vcs_info_msg_0_}
%B%(!.#.$)%b '

export PATH="$HOME/bin:$PATH"


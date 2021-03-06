# History conf
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS SHARE_HISTORY \
    EXTENDED_HISTORY HIST_REDUCE_BLANKS  HIST_IGNORE_SPACE

# Load autocompletion
autoload -U compinit
compinit

# Needed to user colors with fg hash
autoload -U colors
colors

# Version control info
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats ' %F{5}(%F{2}%b%F{3}|%F{1}%a%F{5})%f'
zstyle ':vcs_info:*' formats       ' %F{5}(%F{2}%b%F{3}%m%u%c%F{5})%f'
zstyle ':vcs_info:*' unstagedstr   ' *'
zstyle ':vcs_info:*' stagedstr     '+'

# add a slash when autocompleting special dirs
zstyle ':completion:*' special-dirs true

setup_prompt() {
    local last_exit base vcs post
    # show last command exit code in red
    last_exit='%B%F{red}%(?..%? )%f%b'
    # user@host:path
    base='%F{046}%n@%m%f:%F{012}%~%f'
    # info about current dir vcs
    vcs='${vcs_info_msg_0_}'
    # shows # if root, $ elsewhere
    post='%(!.#.$) '

    PS1="${last_exit}${base}${vcs}${post}"
    #RPROMPT=$'${vcs_info_msg_0_}'
}
setup_prompt

precmd() { vcs_info }

# ZLE in vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward

# This is required to make Home/End/Delete keys work properly
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' ${terminfo[smkx]}
    }
    function zle-line-finish () {
        printf '%s' ${terminfo[rmkx]}
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey -M emacs "${terminfo[khome]}" beginning-of-somewhere
bindkey -M viins "${terminfo[khome]}" vi-beginning-of-line
bindkey -M vicmd "${terminfo[khome]}" vi-beginning-of-line
bindkey -M emacs "${terminfo[kend]}"  end-of-somewhere
bindkey -M viins "${terminfo[kend]}"  vi-end-of-line
bindkey -M vicmd "${terminfo[kend]}"  vi-end-of-line
bindkey -M viins "${terminfo[kdch1]}" vi-delete-char
bindkey -M vicmd "${terminfo[kdch1]}" vi-delete-char
# End of Home/End/Delete setup

# Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias cal='cal -m'
alias tmux='tmux -2'
alias cmount='mount | column -t'
alias feh='feh --scale-down'

# Useful environment
export EDITOR='vim'
export EMAIL='self@miquelruiz.net'

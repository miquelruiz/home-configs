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
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"


precmd() { vcs_info }

# Prompt tunning ($? user@host:path) after loading modules
PS1="%B%F{red}%(?..%? )%f%b%n@%m:%~%# "
RPROMPT=$'${vcs_info_msg_0_}'

# ZLE in vi mode
bindkey -v

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
alias skype='xhost +local: && sudo -u skype /usr/bin/skype'
alias cal='cal -m'
alias tmux='tmux -2'

# Useful environment
export EDITOR='vim'

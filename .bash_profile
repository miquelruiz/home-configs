#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Perlbrew / local::lib stuff
if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    source ~/perl5/perlbrew/etc/bashrc
elif [ -d ~/perl5 ]; then
    eval $(perl -Mlocal::lib)
elif [ -d ~/.plenv ]; then
    export PATH="$HOME/.plenv/bin:$PATH"
    eval "$(plenv init -)"
fi

# rvm stuff
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Go stuff
export GOROOT="$HOME/go"
export GOPATH="$HOME/workspace/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"


# Add stuff to the PATH
export PATH="~/bin:~/.local/bin:~/.cargo/bin:$PATH"


# Use the gpg-agent as ssh-agent
if [ -z "$(pgrep gpg-agent)" ]; then
    eval $(gpg-agent --daemon --enable-ssh-support)
else
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

if [ "$(ssh-add -l)" == "The agent has no identities." ]; then
    ssh-add
fi


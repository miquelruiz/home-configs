#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Perlbrew / local::lib stuff
if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    source ~/perl5/perlbrew/etc/bashrc
elif [ -d ~/perl5 ]; then
    eval $(perl -Mlocal::lib)
fi

# rvm stuff
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# start an SSH agent
eval $(ssh-agent)


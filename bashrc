# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Enable vi mode
set -o vi

export EDITOR=vim
export PAGER=less

# History preferences
HISTCONTROL=erasedups
HISTSIZE=10000
shopt -s histappend # append instead of overwrite history

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set current prompt
# TODO: modify prompt to make it more me
# TODO: determine prompt needs
color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Python Site Packages shortcuts
export SPPATH=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`
alias sp='pushd $SPPATH'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# MVE related environment variables
export GRADLE_OPTS="-Xmx1024m -XX:MaxPermSize=256m -XX:+CMSClassUnloadingEnabled"
export JAVA_HOME=/usr/lib/jvm/java-6-sun

# project location aliases
alias mve='pushd ~/projects/mve'
alias dm-core='pushd ~/projects/dm-core'

# lazy aliases
alias vi='vim'
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias tree='tree -C'
alias trls='tree -C | less -R'
alias mode='(set -o | grep emacs.*on >/dev/null 2>&1 && echo "emacs mode" || echo "vi mode")'
alias g='gnome-open'

# ssh aliases
alias codopolis='ssh djohnston@codopolis.rds.lexmark.com'
alias scpresume="rsync --partial --progress --rsh=ssh"

# reset shell
alias cds='cd; clear'

# If xclip is installed set to copy to system clipboard by default
if [ -f /usr/bin/xclip ]; then
    alias xclip='/usr/bin/xclip -sel c'
fi

# git aliases
if [ -x ~/bin/hub ]; then
    alias git=hub
fi

# reload .bashrc
alias refresh='. ~/.bashrc'

# Source in user functions
if [ -f ~/.user_functions ]; then
    . ~/.user_functions
fi

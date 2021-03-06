setopt appendhistory incappendhistory extendedhistory
setopt autocd beep nomatch interactivecomments 
unsetopt extendedglob notify

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
autoload -Uz compinit
compinit

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# useful for path editing - backward-delete-word, but with / as additional delimiter
backward-delete-to-slash () {
    local WORDCHARS=${WORDCHARS//\//}
    zle .backward-delete-word
}
zle -N backward-delete-to-slash

# Keyboard bindings
bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
#bindkey "^?" backwards-delete-char

# Enabling dynamic titles in XTerm-windows
case $TERM in (xterm*|rxvt*)
    autotitle () {
        precmd () { print -Pn "\e]0;%n@%m: %~\a" }
        preexec () { print -Pn "\e]0;%n@%m: $1\a" }
    }
    title () {
        unfunction precmd  2>/dev/null
        unfunction preexec 2>/dev/null
        print -Pn "\e]0;$@\a"
    }
    autotitle
	;;
esac

ZLS_COLORS=$LS_COLORS
HISTSIZE=1000
SAVEHIST=1000
PATH="${HOME}/bin:/opt/local/bin:/opt/local/sbin:"$PATH

export EDITOR=vi
export VIRSH_DEFAULT_CONNECT_URI=qemu:///system

case $(hostname) in
    'marion'|'otto'|'julius'|'kent'|'stu'|'jimbo')
        if [ $(id -u) -eq 0 ]; then
            PROMPT_COLOR=34         # Blue for root terminal
        else
            if [ "$SSH_TTY" ]; then
                PROMPT_COLOR=33     # Yellow for non-local terminal
            else
                PROMPT_COLOR=32     # Green for local terminal
            fi
        fi
        ;;
    *)
        PROMPT_COLOR=31             # Red for unknown systems
        ;;
esac

case $(uname -s) in
    'Linux')
        # Less Colors for Man Pages
        export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
        export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
        export LESS_TERMCAP_me=$'\E[0m'           # end mode
        export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
        export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
        export LESS_TERMCAP_ue=$'\E[0m'           # end underline
        export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

        alias ls='ls -F --color=auto'
        ;;
    'Darwin')
        alias ls='ls -FG'
        ;;
esac
        
# Finding prompt sign
if [ $(whoami) = "root" ]; then
    PROMPT_SIGN='#'
    # Maybe in shared ~/
    HISTFILE=~/.histfile_jesper
else
    PROMPT_SIGN='%%' # Yes. Two.
    # My own histfile
    HISTFILE=~/.histfile
fi

# Setting up aliases
alias ll='ls -l'
alias la='ls -la'
alias count='sort| uniq -c| sort -n'

# Warning if system wide SendEnv is active in /etc/ssh/ssh_config
if [ -r /etc/ssh/ssh_config ]; then
    WARNING=$(grep SendEnv /etc/ssh/ssh_config | perl -nle 'unless (/^#/) {print "!"}')
fi

# Setting up the prompt
export PS1="$(print '[%T]'${WARNING}' %{\e[1;'${PROMPT_COLOR}'m%}%M%{\e[0m%}') ${PROMPT_SIGN} "
export RPS1="%~"


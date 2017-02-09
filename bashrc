#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Automatically launch tmux if not already inside a tmux session, excluding
# sessions spawned through SSH connections, or we'd have a session leak (i.e.,
# sessions initiated by the SSH connection that are immediately discarded to
# reattach to previously-running tmux sessions).
# See: http://unix.stackexchange.com/a/9607

SESSION_TYPE=''  # default to an empty string for local shell sessions

if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
  SESSION_TYPE='remote/ssh'
else
  case $(ps -o comm= -p ${PPID}) in
    sshd|*/sshd) SESSION_TYPE='remote/ssh';;
  esac
fi

[[ -z "${TMUX}" ]] && [[ -z "${SESSION_TYPE}" ]] && [[ -z "${NO_AUTO_TMUX}" ]] \
  && exec tmux

# {{{ shell options

shopt -s no_empty_cmd_completion
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell
shopt -s globstar
shopt -s nocaseglob
shopt -s histappend
shopt -s cmdhist

# }}} shell options

# {{{ history

export HISTCONTROL="erasedups"

# }}} history

# {{{ aliases

alias grep='grep --color=auto'
alias ls='ls --color=auto'

# }}} aliases

# {{{ prompt

function fancy_prompt() {
  local _rst="\[$(tput sgr0)\]"
  local _bld="\[$(tput bold)\]"
  local _red="\[$(tput setaf 1)\]"
  local _grn="\[$(tput setaf 2)\]"

  local _gitbranch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")"

  PS1="[${_grn}\u@\h${_rst}] ${_bld}${_red}\W${_rst}"
  if [[ -n "${_gitbranch}" ]]; then
    PS1+=" (${_gitbranch})"
  fi
  PS1+="\n\$ "
}

export PROMPT_COMMAND="fancy_prompt"
export PS2=" -> "

# }}} prompt

# {{{ colored gcc output!

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# }}} colored gcc output!

# {{{ colored man pages!

man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
      LESS_TERMCAP_md=$'\E[01;38;5;74m' \
      LESS_TERMCAP_me=$'\E[0m' \
      LESS_TERMCAP_se=$'\E[0m' \
      LESS_TERMCAP_so=$'\E[38;5;246m' \
      LESS_TERMCAP_ue=$'\E[0m' \
      LESS_TERMCAP_us=$'\E[04;38;5;146m' \
      man "${@}"
}

# }}} colored man pages!

# {{{ bash_completion

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

# }}} bash_completion

# {{{ local config

source ~/.bashrc.local

# }}} local

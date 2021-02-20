#!/usr/bin/env zsh

function add-zsh-hook(){
  emulate -L zsh

  local -a hooktypes
  hooktypes=(
    chpwd precmd preexec periodic zshaddhistory zshexit
    zsh_directory_name background
  )
  local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes"

  local opt
  local -a autoopts
  integer del list help

  while getopts "dDhLUzk" opt; do
    case $opt in
        (d)
        del=1
        ;;

        (D)
        del=2
        ;;

        (h)
        help=1
        ;;

        (L)
        list=1
        ;;

        ([Uzk])
        autoopts+=(-$opt)
        ;;

        (*)
        return 1
        ;;
    esac
  done
  shift $(( OPTIND - 1 ))

  if (( list )); then
    typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
    return $?
  elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 )); then
    print -u$(( 2 - help )) $usage
    return $(( 1 - help ))
  fi

  local hook="${1}_functions"
  local fn="$2"

  if (( del )); then
    # delete, if hook is set
    if (( ${(P)+hook} )); then
      if (( del == 2 )); then
        set -A $hook ${(P)hook:#${~fn}}
      else
        set -A $hook ${(P)hook:#$fn}
      fi
      # unset if no remaining entries --- this can give better
      # performance in some cases
      if (( ! ${(P)#hook} )); then
        unset $hook
      fi
    fi
  else
    if (( ${(P)+hook} )); then
      if (( ${${(P)hook}[(I)$fn]} == 0 )); then
        typeset -ga $hook
        set -A $hook ${(P)hook} $fn
      fi
    else
      typeset -ga $hook
      set -A $hook $fn
    fi
    autoload $autoopts -- $fn
  fi

}

function _background_worker() {
  local fn
  for fn in $background_functions; do
    $fn
  done
  sched +5 _background_worker
}

sched +5 _background_worker


function _add_zsh_hook_hooks() {
  local expl
  if (( $+opt_args[-d] )); then
    _wanted functions expl "installed hooks" compadd -a - "$line[1]_functions" && return 0
  else
    _functions && return 0
  fi
  return 1
}

function _add_zsh_hook() {
  local context state state_descr line
  typeset -A opt_args
  _arguments -s -w -S : \
    '(-D)-d[remove HOOK from the array]' \
    '(-d)-D[interpret HOOK as pattern to remove from the array]' \
    {-U,-z,-k}"[passed to 'autoload']" \
    ':hook class:(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name background)' \
    ':hook function:_add_zsh_hook_hooks'
}

compdef _add_zsh_hook add-zsh-hook

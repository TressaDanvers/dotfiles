#!/bin/sh
setopt PROMPT_SUBST

function _prwd() {
  PROJECTS_HOME=$HOME/projects
  case $PWD in
    ($LOCAL_PATH*) echo ${PWD//$LOCAL_PATH/'%F{blue}~%f | %F{blue}exec'}'%f' ;;
    ($XDG_CACHE_HOME*) echo ${PWD//$XDG_CACHE_HOME/'%F{blue}~%f | %F{blue}cache'}'%f' ;;
    ($XDG_CONFIG_HOME*) echo ${PWD//$XDG_CONFIG_HOME/'%F{blue}~%f | %F{blue}config'}'%f' ;;
    ($XDG_DATA_HOME*) echo ${PWD//$XDG_DATA_HOME/'%F{blue}~%f | %F{blue}data'}'%f' ;;
    ($XDG_STATE_HOME*) echo ${PWD//$XDG_STATE_HOME/'%F{blue}~%f | %F{blue}state'}'%f' ;;
    ($XDG_RUNTIME_DIR*) echo ${PWD//$XDG_RUNTIME_DIR/'%F{blue}runtime%f | %F{blue}~'$UID}'%f' ;;
    ($PROJECTS_HOME*) echo ${PWD//$PROJECTS_HOME/'%F{blue}~%f | %F{blue}projects'}'%f' ;;
    (*) echo '%F{blue}%~%f' ;;
  esac
}

function _pgit() {
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
    BRANCH=$(git symbolic-ref HEAD | cut -d'/' -f3)
    if [ -n "$(git status --porcelain)" ]; then
      echo '─[ %F{yellow}'$BRANCH'%f%F{green}*%f ]'
    else
      echo '─[ %F{yellow}'$BRANCH'%f ]'
    fi
  else
    echo ''
  fi
}

PS1="╭─%B[ %n%F{green}@%f%m ]─[ "$'$(_prwd)'" ]"$'$(_pgit)'"%b"$'\n'"╰─$ "

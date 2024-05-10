#!/bin/sh

function _prwd() {
  PROJECTS_HOME=$HOME/projects
  case $PWD in
    ($LOCAL_PATH*) echo -e ${PWD//$LOCAL_PATH/'\033[34m~\033[39m | \033[34mexec'}'\033[39m' ;;
    ($XDG_CACHE_HOME*) echo -e ${PWD//$XDG_CACHE_HOME/'\033[34m~\033[39m | \033[34mcache'}'\033[39m' ;;
    ($XDG_CONFIG_HOME*) echo -e ${PWD//$XDG_CONFIG_HOME/'\033[34m~\033[39m | \033[34mconfig'}'\033[39m' ;;
    ($XDG_DATA_HOME*) echo -e ${PWD//$XDG_DATA_HOME/'\033[34m~\033[39m | \033[34mdata'}'\033[39m' ;;
    ($XDG_STATE_HOME*) echo -e ${PWD//$XDG_STATE_HOME/'\033[34m~\033[39m | \033[34mstate'}'\033[39m' ;;
    ($XDG_RUNTIME_DIR*) echo -e ${PWD//$XDG_RUNTIME_DIR/'\033[34mruntime\033[39m | \033[34m~'$UID}'\033[39m' ;;
    ($PROJECTS_HOME*) echo -e ${PWD//$PROJECTS_HOME/'\033[34m~\033[39m | \033[34mprojects'}'\033[39m' ;;
    ($HOME*) echo -e ${PWD//$HOME/'\033[34m~\033[39m'}'\033[39m' ;;
    (*) echo -e '\033[34m'$PWD'\033[39m' ;;
  esac
}

function _pgit() {
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
    BRANCH=$(git symbolic-ref HEAD | cut -d'/' -f3)
    if [ -n "$(git status --porcelain)" ]; then
      echo -e '─[ \033[33m'$BRANCH'\033[31m*\033[39m ]'
    else
      echo -e '─[ \033[33m'$BRANCH'\033[39m ]'
    fi
  else
    echo -e ''
  fi
}

PS1="╭─\033[1m[ \u\033[32m@\033[39m\h ]─[ "$'$(_prwd)'" ]"$'$(_pgit)'"\033[22m"$'\n'"╰─$ "

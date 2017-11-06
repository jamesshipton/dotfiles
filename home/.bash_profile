# Setup rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

# add vi mappings to bash
set -o vi

### added by the heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Points to the ios compiled app for calybash testing
export APP_BUNDLE_PATH=~/workarea/neo-ios/tmp/build/Neo-Calabash.app

# Put bundle on the path
export PATH="./.bundle/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"

# added by Anaconda3 4.4.0 installer
export PATH="/Users/jamesshipton/anaconda3/bin:$PATH"

export HISTSIZE=100000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

export EDITOR='vim'

export CLICOLOR=1

source ~/.bash_alias

# Set git autocompletion and PS1 integration
source ~/.git-completion.bash

__git_ps1 ()
{
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    printf " (%s)" "${b##refs/heads/}";
  fi
}

__rbenv_ps1 ()
{
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  printf $rbenv_ruby_version
}

function show() {
  atom `bundle show $@`;
}

function ksg() {
  ps aux | grep -ie "$@" | awk '{print $2}' | xargs kill -9;
}

function psg() {
  ps aux | grep -v grep | grep "$@" -i --color=auto;
}

function hsg() {
  history | grep -v grep | grep "$@" -i --color=auto | ruby -e "ARGF.to_a.map { |match| match.sub(/^(\s)*[0-9]+(\s)+/, '') }.uniq.map { |line| puts line.gsub('$@', \"\e[01;33m$@\e[m\") }";
}

# set 2-line color prompt (with git branch if possible)
PS1='\n\[\e[1;35m\]\t\[\e[m\] \[\e[1;32m\]\h\[\e[m\]:\[\e[00m\]\[\e[1;34m\]\w\[\e[m\] \[\e[0;35m\]$(__rbenv_ps1)\[\e[m\] \[\e[00m\]\[\e[01;33m\]$(__git_ps1 " (%s)")\[\e[m\]\n\[\e[1;32m\]\u:->\[\e[m\] '

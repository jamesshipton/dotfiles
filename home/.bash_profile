# tmux fix to make sure that PATH is empty before path_helper runs
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# Setup rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

### added by the heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


# Put bundle on the path
export PATH="./.bundle/bin:$PATH"

# Put bin on the path
export PATH="./bin:$PATH"

# Put node modules bin on the path
export PATH="./node_modules/.bin:$PATH"

export PATH="/usr/local/sbin:$PATH"

export HISTSIZE=500000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

export EDITOR='vim'

export CLICOLOR=1

source ~/.bash_alias

# Set git autocompletion and PS1 integration
source ~/.git-completion.bash

__pipenv_ps1 ()
{
  python_version=`python --version 2>&1 | awk '{print $2}'`
  if [[ $VIRTUAL_ENV ]]; then
    venv_path=$VIRTUAL_ENV
    venv_dir=${venv_path%/*}
    venv_env=${venv_dir##*/}
    printf "  $python_version-$venv_env  "
  else
    printf "  $python_version  "
  fi
}

__gcp_account_ps1 ()
{
  if [ -f ".gcloudignore" ]; then
    gcp_config_name=`cat ~/.config/gcloud/active_config`
    printf " $gcp_config_name  "
  fi
}

__rbenv_ps1 ()
{
  rbenv_ruby_version=`rbenv version | sed -e 's/ .*//'`
  printf " $rbenv_ruby_version  "
}

__git_ps1 ()
{
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    printf " %s" "${b##refs/heads/}";
  fi
}

function show() {
  mate `bundle show $@`;
}

function ksg() {
  ps aux | grep -ie "$@" | awk '{print $2}' | xargs kill -9;
}

function psg() {
  ps aux | grep -v grep | grep "$@" -i --color=auto;
}

function hsg() {
  cat ~/.bash_history | nl | sort -k 2 | uniq -f 1 | sort -n | cut -f 2 > ~/temp.txt
  mv ~/temp.txt ~/.bash_history
  history | grep -v grep | grep "$@" -i --color=auto
}

# set 2-line color prompt (with git branch if possible)
PS1='\n\[\e[1;35m\]\t\[\e[m\] \
\[\e[1;32m\]\h\[\e[m\]:\[\e[00m\]\[\e[1;34m\]\w\[\e[m\] \
\[\e[0;36m\]$(__pipenv_ps1)\[\e[m\]\
\[\e[0;32m\]$(__gcp_account_ps1)\[\e[m\]\
\[\e[0;35m\]$(__rbenv_ps1)\[\e[m\]\
\[\e[00m\]\[\e[01;33m\]$(__git_ps1 " (%s)")\[\e[m\]\n\
\[\e[1;32m\]\$:->\[\e[m\] '

cd () { builtin cd "$@" && chpwd; }

chpwd () {
  activate_pipenv
}

activate_pipenv() {
  if [ -d ".venv" ] && [ ! $VIRTUAL_ENV ]; then
    source $(pipenv --venv)/bin/activate
  elif [ ! -d ".venv" ] && [ $VIRTUAL_ENV ]; then
    source deactivate
  fi
}

# Setup pypython
export PTPYTHON_CONFIG_HOME="/Users/james/.ptpython/"

# Setup pyenv
export PATH="/Users/james/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Setup pipenv
export PIPENV_VENV_IN_PROJECT=true
export PIPENV_VERBOSITY=-1
export VIRTUAL_ENV_DISABLE_PROMPT=true

# remove duplicate path entries
PATH=$(printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')

# java path
export JAVA_HOME_8=$(/usr/libexec/java_home -v1.8)
export JAVA_HOME_15=$(/usr/libexec/java_home -v15)

export JAVA_HOME=$JAVA_HOME_8

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

### Put anaconda on the path
# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

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

__conda_ps1 ()
{
  python_version=`python --version 2>&1 | awk '{print $2}'`
  if [[ $CONDA_DEFAULT_ENV ]]; then
    conda_env_path=$CONDA_DEFAULT_ENV
    conda_env=${conda_env_path##*/}
    printf "  $python_version-c-$conda_env  "
  elif [[ $VIRTUAL_ENV ]]; then
    venv_path=$VIRTUAL_ENV
    venv_dir=${venv_path%/*}
    venv_env=${venv_dir##*/}
    printf "  $python_version-v-$venv_env  "
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# set 2-line color prompt (with git branch if possible)
PS1='\n\[\e[1;35m\]\t\[\e[m\] \
\[\e[1;32m\]\h\[\e[m\]:\[\e[00m\]\[\e[1;34m\]\w\[\e[m\] \
\[\e[0;36m\]$(__conda_ps1)\[\e[m\]\
\[\e[0;32m\]$(__gcp_account_ps1)\[\e[m\]\
\[\e[0;35m\]$(__rbenv_ps1)\[\e[m\]\
\[\e[00m\]\[\e[01;33m\]$(__git_ps1 " (%s)")\[\e[m\]\n\
\[\e[1;32m\]\$:->\[\e[m\] '

cd () { builtin cd "$@" && chpwd; }

chpwd () {
  activate_conda
  activate_pipenv
}

activate_conda() {
  FILE="$(find -E . -maxdepth 1 -regex '.*(env(ironment)?|requirements)\.ya?ml' -print -quit)"
  if [[ -e $FILE ]]; then
    ENV=$(sed -n 's/name: //p' $FILE)
    CONDA_ENV_PATH=$CONDA_DEFAULT_ENV
    CONDA_ENV="${CONDA_ENV_PATH##*/}"
    # check if env already active
    if [[ $CONDA_ENV != $ENV ]]; then
      conda activate $ENV
      # if env activation unsuccessful, create new env from file
      if [ $? -ne 0 ]; then
        echo "Conda environment '$ENV' doesn't exist. Creating it now."
        conda env create -q
        conda activate $ENV
      fi
      CONDA_ENV_ROOT="$(pwd)"
    fi
  # deactivate env when exiting root dir
  elif [[ $PATH = */\.envs/* ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT/* ]]
  then
    CONDA_ENV_ROOT=""
    conda deactivate
  fi
}

activate_pipenv() {
  if [ -d ".venv" ] && [ ! $VIRTUAL_ENV ]; then
    source $(pipenv --venv)/bin/activate
  elif [ ! -d ".venv" ] && [ $VIRTUAL_ENV ]; then
    source deactivate
  fi
}

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

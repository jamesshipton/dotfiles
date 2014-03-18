# Setup rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

# Put bundle on the path
PATH="./.bundle/bin:$PATH"

if [ -f $HOME/.aws-credentials-master ]; then
	export AWS_CREDENTIAL_FILE=$HOME/.aws-credentials-master
	export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.15.1/jars"
	export AWS_IAM_HOME="/usr/local/Cellar/aws-iam-tools/HEAD/jars"
	export AWS_RDS_HOME="/usr/local/Cellar/rds-command-line-tools/1.3.003/jars"
	export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.4.4.1/jars"
	export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
	export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
	export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
	export AWS_CLOUDWATCH_HOME="/usr/local/Cellar/cloud-watch/1.0.12.1/jars"
  export SERVICE_HOME="$AWS_CLOUDWATCH_HOME"
fi

if [ -f $HOME/.campfire-token ]; then
  source "$HOME/.campfire-token"
fi

if [ -f $HOME/.tapas_auth ]; then
  source "$HOME/.tapas_auth"
fi

export HISTCONTROL=ignorespace
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export EDITOR=mate

if ! ps aux |grep '[d]ude' >/dev/null ; then
  git dude ~/.git-dude >/dev/null 2>&1 &
fi

export RAILS_SPRING=true

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

function psgrep() {
  ps aux | grep -v grep | grep "$@" -i --color=auto;
}

# set 2-line color prompt (with git branch if possible)
if type __git_ps1 >/dev/null 2>&1; then
  PS1='\n\[\033[01;35m\]\t \[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\[\033[01;32m\]\u\[\033[00m\]:-> '
else
  PS1='\n\[\033[01;35m\]\t \[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;32m\]\u\[\033[00m\]:-> '
fi


#!/usr/bin/env bash

# usage: to create a project/session, create a symlink in .projects to the working directory 
# the name of the symlink is the name of the project

# if there is no path specified, prompt via fzf
if ! [[ -d $HOME/.projects ]]; then
  echo "Error: Couldn't find '~/.projects' directory." >&2
  exit 1
fi

if [[ $# -eq 1 ]]; then
  input=$1
else
  input=$(cd $HOME/.projects; find . -type l | sed 's/^\.\///' | fzf)
fi

if [[ -z $input ]]; then
  exit 0
fi

project_name=$input
project_dir=$(readlink "$HOME/.projects/$project_name")

if ! [[ -d $project_dir ]]; then
  echo "Error: Directory '$project_dir' does not exist." >&2
  exit 1
fi

if [[ -z $(pgrep tmux) ]]; then
  tmux start-sever # blocking
fi

if ! tmux has-session -t $project_name 2> /dev/null; then
  tmux new -ds $project_name -c $project_dir
fi

if ! [[ -f ${project_dir}/Session.vim ]]; then
  $(cd $project_dir; nvim --headless +Obsession +q >/dev/null 2>&1) 
fi

if [[ $TMUX ]]; then
  tmux switch-client -t $project_name
else
  tmux a -t $project_name
fi


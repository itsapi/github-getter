#!/bin/bash

name="$1"
branch="$2"
ssh_host="git@github.com:$name"
path="/home/git/post-receive/processing"
repo="/home/git/$name.git"

mkdir $path
shopt -s extglob
rm -rf $path/!(node_modules)

if [ ! -d $repo ]; then
  mkdir -p $repo
  git init --bare $repo
fi

cd $repo

git fetch $ssh_host $branch:$branch -f
export GIT_WORK_TREE=$path
git checkout $branch -f

cd $path

python3 ../main.py "$name"

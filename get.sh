#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Usage: ./get.sh [repo-dir] [output-dir] [user]/[reponame] [branch]"
    exit 1
fi

repos_path="$1"
output_dir="$2"
name="$3"
branch="$4"
ssh_host="git@github.com:$name"
repo_path="$name.git"

mkdir $output_dir
shopt -s extglob
rm -rf $output_dir/!(node_modules)

cd $repos_path

if [ ! -d $repo_path ]; then
  mkdir -p $repo_path
  git init --bare $repo_path
fi

cd $repo_path

git fetch $ssh_host $branch:$branch -f
export GIT_WORK_TREE=$output_dir
git checkout $branch -f

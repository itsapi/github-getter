#!/bin/bash

if [ $# -ne 5 ] && [ $# -ne 4 ]; then
    echo "Usage: ./get.sh [repo-dir] [output-dir] [user]/[reponame] [branch] [url]"
    exit 1
fi

repos_path="$1"
output_dir="$2"
name="$3"
branch="$4"

if [ -z "$5" ]; then
	url="git@github.com"
else
	url="$5"
fi

ssh_host="$url:$name"
repo_path="$repos_path/$name.git"

mkdir -p $output_dir
shopt -s extglob
rm -rf $output_dir/!(node_modules)

if [ ! -d $repo_path ]; then
  git init --bare $repo_path
fi

cd $repo_path

git fetch $ssh_host "$branch:$branch" -f
GIT_WORK_TREE=$output_dir git checkout $branch -f

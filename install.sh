#!/usr/bin/env bash
set -eu -o pipefail
shopt -s extglob
CWD=$(cd $(dirname $0); pwd)

ln -fs $CWD/dig/digrc ~/.digrc 
ln -fs $CWD/git/gitconfig ~/.gitconfig
#ln -fs $CWD/kube ~/.kube
ln -fs $CWD/psqlrc ~/.psqlrc
ln -fs $CWD/dsh ~/.dsh
mkdir -p ~/.ssh
ln -fs $CWD/ssh/config ~/.ssh/config
ln -fs $CWD/vim/vimrc ~/.vimrc

for rcfile in $CWD/zsh/z{shenv,shrc,login,logout}; do 
    ln -fs $rcfile ~/.`basename $rcfile` 
done

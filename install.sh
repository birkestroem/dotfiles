#!/usr/bin/env bash
set -eu -o pipefail
shopt -s extglob
CWD=$(cd $(dirname $0); pwd)

ln -fs $CWD/dig/digrc ~/.digrc 
ln -fs $CWD/git/gitconfig ~/.gitconfig
ln -fs $CWD/psqlrc ~/.psqlrc
ln -fs $CWD/dsh ~/.dsh

if [ ! -d ~/.ssh ]; then
    mkdir -p ~/.ssh
fi

ln -fs $CWD/ssh/config ~/.ssh/config
ln -fs $CWD/vim/vimrc ~/.vimrc

for rcfile in $CWD/zsh/z{shenv,shrc,login,logout}; do 
    ln -fs $rcfile ~/.`basename $rcfile` 
done

LOCAL_ZSHRC="$CWD/zsh/zshrc.local.$(hostname -s)"
if [ ! -f $LOCAL_ZSHRC ]; then
    touch $LOCAL_ZSHRC
fi
ln -fs $LOCAL_ZSHRC  ~/.zshrc.local

ln -fs $CWD/condarc ~/.condarc
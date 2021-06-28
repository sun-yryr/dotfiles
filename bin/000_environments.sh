#!/bin/zsh

# 前処理 カレントディレクトリを保存する
CURRENT_DIR=`pwd`

DOTFILES_BIN_ROOT=$(cd $(dirname "$0"); pwd)
DOTFILES_ROOT=`dirname "$DOTFILES_BIN_ROOT"`

# 後処理 カレントディレクトリを元に戻す
cd $CURRENT_DIR

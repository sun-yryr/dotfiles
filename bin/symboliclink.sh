#!/bin/bash

# dotfilesのパス
DOTFILES_PATH=$(cd $(dirname $0); pwd)

# シンボリックリンクを貼る
ln -sf "$DOTFILES_PATH/../.xonshrc" $HOME
mkdir -p "$HOME/.ssh"
cp "$DOTFILES_PATH/../ssh_config" "$HOME/.ssh/config"

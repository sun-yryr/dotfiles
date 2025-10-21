#!/bin/bash

# Ubuntuでのdotfilesのセットアップスクリプト

# 必要なパッケージをインストール
echo "必要なパッケージをインストールします..."
sudo apt-get update
sudo apt-get install -y \
    zsh curl fzf build-essential libssl-dev \
    tmux cmake ca-certificates libncurses-dev

# Dockerをインストール
if ! command -v docker &> /dev/null; then
    echo "Dockerをインストールします..."
    # FYI: https://docs.docker.com/engine/install/ubuntu/
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# swiftly
if ! command -v swiftly &> /dev/null; then
    echo "swiftlyをインストールします..."
    curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz
    tar zxf swiftly-$(uname -m).tar.gz
    ./swiftly init --quiet-shell-followup
    . ~/.local/share/swiftly/env.sh
    hash -r
fi

# シェルをzshに変更
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "シェルをzshに変更します..."
    chsh -s $(which zsh)
fi

echo "Ubuntuのセットアップが完了しました！"

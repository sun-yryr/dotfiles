#!/bin/bash

# macOSでのdotfilesのセットアップスクリプト

# Homebrewがインストールされているか確認
if ! command -v brew &> /dev/null; then
    echo "Homebrewをインストールします..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 必要なパッケージをインストール
echo "必要なパッケージをインストールします..."
brew install zsh curl fzf ghr

# swiftly
if ! command -v swiftly &> /dev/null; then
    echo "swiftlyをインストールします..."
    curl -O https://download.swift.org/swiftly/darwin/swiftly.pkg
    installer -pkg swiftly.pkg -target CurrentUserHomeDirectory
    ~/.swiftly/bin/swiftly init --quiet-shell-followup
    . ~/.swiftly/env.sh
    hash -r
fi

# シェルをzshに変更（macOSはデフォルトでzshを使用しているため、通常は不要）
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "シェルをzshに変更します..."
    chsh -s $(which zsh)
fi

echo "macOSのセットアップが完了しました！"

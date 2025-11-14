#!/bin/bash

# dotfilesのインストールスクリプト

# 現在のディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 必要なディレクトリを作成
mkdir -p ~/.config

# OSを検出
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "macOSを検出しました。"
    OS_TYPE="macos"
    # macOS固有のセットアップを実行
    "$DOTFILES_DIR/os/macos/setup.sh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
            echo "Ubuntuを検出しました。"
            OS_TYPE="ubuntu"
            # Ubuntu固有のセットアップを実行
            "$DOTFILES_DIR/os/ubuntu/setup.sh"
        else
            echo "サポートされていないLinuxディストリビューションです。"
            exit 1
        fi
    else
        echo "サポートされていないLinuxディストリビューションです。"
        exit 1
    fi
else
    echo "サポートされていないOSです。"
    exit 1
fi

# インストーラーが自動選択なものはここで入れる
# starshipがインストールされているか確認
if ! command -v starship &> /dev/null; then
    echo "starshipをインストールします..."
    curl -sS https://starship.rs/install.sh | sh
fi
# zplugがインストールされているか確認
if ! command -v zplug &> /dev/null; then
    echo "zplugをインストールします..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
# miseがインストールされているか確認
if ! command -v mise &> /dev/null; then
    echo "miseをインストールします..."
    curl https://mise.run | sh
fi
# uvがインストールされているか確認
if ! command -v uv &> /dev/null; then
    echo "uvをインストールします..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
# rustupがインストールされているか確認
if ! command -v rustup &> /dev/null; then
    echo "rustupをインストールします..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
# ghrがインストールされているか確認
if ! command -v ghr &> /dev/null; then
    echo "ghrをインストールします..."
    cargo install ghr
fi
# tmux pluginのセットアップ
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "tmux plugin managerをインストールします..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 共通の設定ファイルのシンボリックリンクを作成
echo "設定ファイルのシンボリックリンクを作成します..."

# zshrcのシンボリックリンクを作成
echo "zshrcのシンボリックリンクを作成します..."
ln -sf "$DOTFILES_DIR/shell/zsh/zshrc" ~/.zshrc

# starship.tomlのシンボリックリンクを作成
echo "starship.tomlのシンボリックリンクを作成します..."
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/terminal/starship/starship.toml" ~/.config/starship.toml

# ghrの設定ファイルのシンボリックリンクを作成
echo "ghrの設定ファイルのシンボリックリンクを作成します..."
mkdir -p ~/.config/ghr
ln -sf "$DOTFILES_DIR/git/ghr/config.toml" ~/.config/ghr/config.toml

# gitconfig, ignoreのシンボリックリンクを作成
echo "gitconfig, ignoreのシンボリックリンクを作成します..."
ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig
mkdir -p ~/.config/git
ln -sf "$DOTFILES_DIR/git/ignore" ~/.config/git/ignore

# enhancdの設定ファイルのシンボリックリンクを作成
echo "enhancdの設定ファイルのシンボリックリンクを作成します..."
mkdir -p ~/.enhancd
ln -sf "$DOTFILES_DIR/shell/enhancd/config.ltsv" ~/.enhancd/config.ltsv

# tmuxの設定ファイルのシンボリックリンクを作成
echo "tmuxの設定ファイルのシンボリックリンクを作成します..."
ln -sf "$DOTFILES_DIR/terminal/tmux/tmux.conf" ~/.tmux.conf

echo "インストールが完了しました！"
echo "変更を適用するには、ターミナルを再起動するか、以下のコマンドを実行してください："
echo "exec zsh"

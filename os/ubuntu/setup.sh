#!/bin/bash

# Ubuntuでのdotfilesのセットアップスクリプト

set -euo pipefail

# 現在のディレクトリを取得（DOTFILES_DIRが未設定の場合）
if [ -z "${DOTFILES_DIR:-}" ]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
fi

# 関数ライブラリを読み込む
source "$DOTFILES_DIR/lib/functions.sh"

# 必要なパッケージをインストール
step_start "必要なパッケージのインストール"
info "パッケージリストを更新中..."
if run_command "sudo apt-get update" "パッケージリストを更新中..."; then
    info "zsh, curl, fzf, build-essential等をインストールします..."
    if run_command "sudo apt-get install -y zsh curl fzf build-essential libssl-dev tmux cmake ca-certificates libncurses-dev" "パッケージをインストール中..."; then
        step_success
    else
        step_error "パッケージのインストールに失敗しました。"
    fi
else
    step_error "パッケージリストの更新に失敗しました。"
fi

# Dockerをインストール
step_start "Dockerのインストール確認"
if command -v docker &> /dev/null; then
    info "Dockerは既にインストールされています。"
    step_skip
else
    info "Dockerをインストールします..."
    # FYI: https://docs.docker.com/engine/install/ubuntu/
    if run_silent "sudo install -m 0755 -d /etc/apt/keyrings"; then
        if run_command "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc" "Docker GPGキーをダウンロード中..."; then
            if run_silent "sudo chmod a+r /etc/apt/keyrings/docker.asc"; then
                if run_silent "echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \$(. /etc/os-release && echo \"\${UBUNTU_CODENAME:-\$VERSION_CODENAME}\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"; then
                    if run_command "sudo apt-get update" "Dockerリポジトリを更新中..."; then
                        if run_command "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin" "Dockerをインストール中..."; then
                            step_success
                        else
                            step_error "Dockerのインストールに失敗しました。"
                        fi
                    else
                        step_error "Dockerリポジトリの更新に失敗しました。"
                    fi
                else
                    step_error "Dockerリポジトリの追加に失敗しました。"
                fi
            else
                step_error "GPGキーの権限設定に失敗しました。"
            fi
        else
            step_error "Docker GPGキーのダウンロードに失敗しました。"
        fi
    else
        step_error "keyringsディレクトリの作成に失敗しました。"
    fi
fi

# swiftly
step_start "swiftlyのインストール確認"
if command -v swiftly &> /dev/null; then
    info "swiftlyは既にインストールされています。"
    step_skip
else
    info "swiftlyをインストールします..."
    arch=$(uname -m)
    if run_command "curl -O https://download.swift.org/swiftly/linux/swiftly-${arch}.tar.gz" "swiftlyをダウンロード中..."; then
        if run_command "tar zxf swiftly-${arch}.tar.gz" "swiftlyを展開中..."; then
            if run_silent "./swiftly init --quiet-shell-followup"; then
                if [ -f ~/.local/share/swiftly/env.sh ]; then
                    . ~/.local/share/swiftly/env.sh
                    hash -r
                fi
                step_success
            else
                step_error "swiftlyの初期化に失敗しました。"
            fi
        else
            step_error "swiftlyの展開に失敗しました。"
        fi
    else
        step_error "swiftlyのダウンロードに失敗しました。"
    fi
fi

# シェルをzshに変更
step_start "シェルの確認"
if [[ "$SHELL" == *"zsh"* ]]; then
    info "既にzshが使用されています。"
    step_skip
else
    info "シェルをzshに変更します..."
    if run_command "chsh -s \$(which zsh)" "シェルを変更中..."; then
        step_success
        warn "変更を反映するには、ターミナルを再起動してください。"
    else
        step_error "シェルの変更に失敗しました。"
    fi
fi

info "Ubuntuのセットアップが完了しました！"

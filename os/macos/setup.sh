#!/bin/bash

# macOSでのdotfilesのセットアップスクリプト

set -euo pipefail

# 現在のディレクトリを取得（DOTFILES_DIRが未設定の場合）
if [ -z "${DOTFILES_DIR:-}" ]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
fi

# 関数ライブラリを読み込む
source "$DOTFILES_DIR/lib/functions.sh"

# Homebrewがインストールされているか確認
step_start "Homebrewのインストール確認"
if command -v brew &> /dev/null; then
    info "Homebrewは既にインストールされています。"
    step_skip
else
    info "Homebrewをインストールします..."
    if run_command "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" "Homebrewをダウンロード・インストール中..."; then
        step_success
    else
        step_error "Homebrewのインストールに失敗しました。"
    fi
fi

# 必要なパッケージをインストール
step_start "必要なパッケージのインストール"
info "fzf, ghrをインストールします..."
if run_command "brew install fzf ghr" "パッケージをインストール中..."; then
    step_success
else
    step_error "パッケージのインストールに失敗しました。"
fi

# swiftly
step_start "swiftlyのインストール確認"
if command -v swiftly &> /dev/null; then
    info "swiftlyは既にインストールされています。"
    step_skip
else
    info "swiftlyをインストールします..."
    if run_command "curl -O https://download.swift.org/swiftly/darwin/swiftly.pkg" "swiftlyをダウンロード中..."; then
        if run_command "installer -pkg swiftly.pkg -target CurrentUserHomeDirectory" "swiftlyをインストール中..."; then
            if run_silent "~/.swiftly/bin/swiftly init --quiet-shell-followup"; then
                if [ -f ~/.swiftly/env.sh ]; then
                    . ~/.swiftly/env.sh
                    hash -r
                fi
                step_success
            else
                step_error "swiftlyの初期化に失敗しました。"
            fi
        else
            step_error "swiftlyのインストールに失敗しました。"
        fi
    else
        step_error "swiftlyのダウンロードに失敗しました。"
    fi
fi

# シェルをzshに変更（macOSはデフォルトでzshを使用しているため、通常は不要）
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

info "macOSのセットアップが完了しました！"

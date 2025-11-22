#!/bin/bash

# dotfilesのインストールスクリプト

set -euo pipefail

# 現在のディレクトリを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 関数ライブラリを読み込む
source "$DOTFILES_DIR/lib/functions.sh"

# グローバル変数の初期化
START_TIME=$(date +%s)
TOTAL_STEPS=20  # OS検出(1) + ツールインストール(6) + シンボリックリンク(7) + その他
CURRENT_STEP=0

# ヘッダー表示
show_header

# 必要なディレクトリを作成
step_start "初期ディレクトリの作成"
mkdir -p ~/.config
step_success

# OSを検出
step_start "OSの検出"
OS_TYPE=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    OS_TYPE="macos"
    info "macOSを検出しました。"
    step_success
    
    step_start "macOS固有のセットアップ"
    if [ -f "$DOTFILES_DIR/os/macos/setup.sh" ]; then
        if run_command "\"$DOTFILES_DIR/os/macos/setup.sh\"" "macOSセットアップスクリプトを実行中..."; then
            step_success
        else
            step_error "macOSセットアップスクリプトの実行に失敗しました。"
        fi
    else
        warn "macOSセットアップスクリプトが見つかりません。スキップします。"
        step_skip
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
            OS_TYPE="ubuntu"
            info "Ubuntuを検出しました。"
            step_success
            
            step_start "Ubuntu固有のセットアップ"
            if [ -f "$DOTFILES_DIR/os/ubuntu/setup.sh" ]; then
                if run_command "\"$DOTFILES_DIR/os/ubuntu/setup.sh\"" "Ubuntuセットアップスクリプトを実行中..."; then
                    step_success
                else
                    step_error "Ubuntuセットアップスクリプトの実行に失敗しました。"
                fi
            else
                warn "Ubuntuセットアップスクリプトが見つかりません。スキップします。"
                step_skip
            fi
        else
            step_error "サポートされていないLinuxディストリビューションです: $ID"
        fi
    else
        step_error "サポートされていないLinuxディストリビューションです。"
    fi
else
    step_error "サポートされていないOSです: $OSTYPE"
fi

# インストーラーが自動選択なものはここで入れる
step_start "starshipのインストール確認"
if command -v starship &> /dev/null; then
    info "starshipは既にインストールされています。"
    step_skip
else
    info "starshipをインストールします..."
    if run_command "curl -sS https://starship.rs/install.sh | sh" "starshipをダウンロード・インストール中..."; then
        step_success
    else
        step_error "starshipのインストールに失敗しました。"
    fi
fi

step_start "zplugのインストール確認"
if command -v zplug &> /dev/null; then
    info "zplugは既にインストールされています。"
    step_skip
else
    info "zplugをインストールします..."
    if run_command "curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh" "zplugをダウンロード・インストール中..."; then
        step_success
    else
        step_error "zplugのインストールに失敗しました。"
    fi
fi

step_start "miseのインストール確認"
if command -v mise &> /dev/null; then
    info "miseは既にインストールされています。"
    step_skip
else
    info "miseをインストールします..."
    if run_command "curl https://mise.run | sh" "miseをダウンロード・インストール中..."; then
        step_success
    else
        step_error "miseのインストールに失敗しました。"
    fi
fi

step_start "uvのインストール確認"
if command -v uv &> /dev/null; then
    info "uvは既にインストールされています。"
    step_skip
else
    info "uvをインストールします..."
    if run_command "curl -LsSf https://astral.sh/uv/install.sh | sh" "uvをダウンロード・インストール中..."; then
        step_success
    else
        step_error "uvのインストールに失敗しました。"
    fi
fi

step_start "rustupのインストール確認"
if command -v rustup &> /dev/null; then
    info "rustupは既にインストールされています。"
    step_skip
else
    info "rustupをインストールします..."
    if run_command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" "rustupをダウンロード・インストール中..."; then
        step_success
    else
        step_error "rustupのインストールに失敗しました。"
    fi
fi

step_start "ghrのインストール確認"
if command -v ghr &> /dev/null; then
    info "ghrは既にインストールされています。"
    step_skip
else
    if ! command -v cargo &> /dev/null; then
        warn "cargoが見つかりません。rustupのインストールが必要です。"
        if confirm "ghrのインストールをスキップしますか？" "y"; then
            step_skip
        else
            step_error "cargoが必要ですが見つかりませんでした。"
        fi
    else
        info "ghrをインストールします（時間がかかる場合があります）..."
        if run_command "cargo install ghr" "ghrをビルド・インストール中..."; then
            step_success
        else
            step_error "ghrのインストールに失敗しました。"
        fi
    fi
fi

step_start "tmux plugin managerのインストール確認"
if [ -d ~/.tmux/plugins/tpm ]; then
    info "tmux plugin managerは既にインストールされています。"
    step_skip
else
    info "tmux plugin managerをインストールします..."
    if run_silent "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"; then
        step_success
    else
        step_error "tmux plugin managerのインストールに失敗しました。"
    fi
fi

# 共通の設定ファイルのシンボリックリンクを作成
step_start "zshrcのシンボリックリンク作成"
if ln -sf "$DOTFILES_DIR/shell/zsh/zshrc" ~/.zshrc; then
    step_success
else
    step_error "zshrcのシンボリックリンク作成に失敗しました。"
fi

step_start "starship.tomlのシンボリックリンク作成"
mkdir -p ~/.config
if ln -sf "$DOTFILES_DIR/terminal/starship/starship.toml" ~/.config/starship.toml; then
    step_success
else
    step_error "starship.tomlのシンボリックリンク作成に失敗しました。"
fi

step_start "ghr設定ファイルのシンボリックリンク作成"
mkdir -p ~/.config/ghr
if ln -sf "$DOTFILES_DIR/git/ghr/config.toml" ~/.ghr/ghr.toml; then
    step_success
else
    step_error "ghr設定ファイルのシンボリックリンク作成に失敗しました。"
fi

step_start "gitconfigのシンボリックリンク作成"
if ln -sf "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig; then
    step_success
else
    step_error "gitconfigのシンボリックリンク作成に失敗しました。"
fi

step_start "git ignoreのシンボリックリンク作成"
mkdir -p ~/.config/git
if ln -sf "$DOTFILES_DIR/git/ignore" ~/.config/git/ignore; then
    step_success
else
    step_error "git ignoreのシンボリックリンク作成に失敗しました。"
fi

step_start "enhancd設定ファイルのシンボリックリンク作成"
mkdir -p ~/.enhancd
if ln -sf "$DOTFILES_DIR/shell/enhancd/config.ltsv" ~/.enhancd/config.ltsv; then
    step_success
else
    step_error "enhancd設定ファイルのシンボリックリンク作成に失敗しました。"
fi

step_start "tmux設定ファイルのシンボリックリンク作成"
if ln -sf "$DOTFILES_DIR/terminal/tmux/tmux.conf" ~/.tmux.conf; then
    step_success
else
    step_error "tmux設定ファイルのシンボリックリンク作成に失敗しました。"
fi

# 総実行時間を計算
END_TIME=$(date +%s)
TOTAL_DURATION=$((END_TIME - START_TIME))
TOTAL_DURATION_STR=$(format_duration $TOTAL_DURATION)

# 完了メッセージ
show_footer "$TOTAL_DURATION_STR"

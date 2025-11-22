#!/bin/bash

# dotfiles インストーラー用のヘルパー関数ライブラリ

# 色とアイコンの定義
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

readonly ICON_SUCCESS="✓"
readonly ICON_ERROR="✗"
readonly ICON_INFO="ℹ"
readonly ICON_WARNING="⚠"

# グローバル変数（外部から設定される）
TOTAL_STEPS=0
CURRENT_STEP=0
START_TIME=0

# 関数: 時間をフォーマット
format_duration() {
    local seconds=$1
    if [ $seconds -lt 60 ]; then
        echo "${seconds}s"
    elif [ $seconds -lt 3600 ]; then
        local mins=$((seconds / 60))
        local secs=$((seconds % 60))
        echo "${mins}m ${secs}s"
    else
        local hours=$((seconds / 3600))
        local mins=$(((seconds % 3600) / 60))
        local secs=$((seconds % 60))
        echo "${hours}h ${mins}m ${secs}s"
    fi
}

# 関数: ステップ開始
step_start() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    local step_name="$1"
    local step_start_time=$(date +%s)
    echo -e "${CYAN}=>${NC} ${BOLD}[${CURRENT_STEP}/${TOTAL_STEPS}]${NC} ${step_name}..."
    echo "$step_start_time" > /tmp/dotfiles_step_time_${CURRENT_STEP}
}

# 関数: ステップ成功
step_success() {
    local step_duration=$(cat /tmp/dotfiles_step_time_${CURRENT_STEP} 2>/dev/null || echo "$(date +%s)")
    local current_time=$(date +%s)
    local duration=$((current_time - step_duration))
    local duration_str=$(format_duration $duration)
    echo -e "${GREEN}${ICON_SUCCESS}${NC} ${BOLD}[${CURRENT_STEP}/${TOTAL_STEPS}]${NC} 完了 (${duration_str})"
    rm -f /tmp/dotfiles_step_time_${CURRENT_STEP}
}

# 関数: ステップスキップ
step_skip() {
    local step_duration=$(cat /tmp/dotfiles_step_time_${CURRENT_STEP} 2>/dev/null || echo "$(date +%s)")
    local current_time=$(date +%s)
    local duration=$((current_time - step_duration))
    local duration_str=$(format_duration $duration)
    echo -e "${YELLOW}${ICON_WARNING}${NC} ${BOLD}[${CURRENT_STEP}/${TOTAL_STEPS}]${NC} スキップ (${duration_str})"
    rm -f /tmp/dotfiles_step_time_${CURRENT_STEP}
}

# 関数: ステップエラー
step_error() {
    local error_msg="$1"
    echo -e "${RED}${ICON_ERROR}${NC} ${BOLD}[${CURRENT_STEP}/${TOTAL_STEPS}]${NC} エラー: ${error_msg}"
    rm -f /tmp/dotfiles_step_time_${CURRENT_STEP}
    exit 1
}

# 関数: 情報表示
info() {
    echo -e "${BLUE}${ICON_INFO}${NC} $1"
}

# 関数: 警告表示
warn() {
    echo -e "${YELLOW}${ICON_WARNING}${NC} $1"
}

# 関数: インタラクティブな確認
confirm() {
    local prompt="$1"
    local default="${2:-n}"
    local response
    
    if [ "$default" = "y" ]; then
        local options="[Y/n]"
    else
        local options="[y/N]"
    fi
    
    while true; do
        echo -ne "${CYAN}${ICON_INFO}${NC} ${prompt} ${options}: "
        read -r response < /dev/tty || response="$default"
        response=${response:-$default}
        case "$response" in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "y または n を入力してください。";;
        esac
    done
}

# 関数: 行を消去（カーソルを1行上に移動して行を消去）
clear_line() {
    echo -ne "\033[A\033[2K"
}

# 関数: コマンド実行（インタラクティブ対応）
run_command() {
    local cmd="$1"
    local description="${2:-}"
    local info_printed=false
    
    if [ -n "$description" ]; then
        info "$description"
        info_printed=true
    fi
    
    # インタラクティブなコマンドの場合は標準入力を接続
    if eval "$cmd"; then
        # 成功時はinfoで表示した行を消去
        if [ "$info_printed" = true ]; then
            clear_line
        fi
        return 0
    else
        # エラー時は出力をそのまま残す
        return 1
    fi
}

# 関数: 非インタラクティブコマンド実行
run_silent() {
    local cmd="$1"
    eval "$cmd" > /dev/null 2>&1
}

# 関数: ヘッダー表示
show_header() {
    echo -e "${BOLD}${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║           dotfiles インストーラー                        ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 関数: フッター表示
show_footer() {
    local total_duration_str="$1"
    echo ""
    echo -e "${BOLD}${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║           インストールが完了しました！                    ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${GREEN}${ICON_SUCCESS}${NC} 総実行時間: ${BOLD}${total_duration_str}${NC}"
    echo ""
    info "変更を適用するには、ターミナルを再起動するか、以下のコマンドを実行してください："
    echo -e "  ${CYAN}exec zsh${NC}"
    echo ""
}


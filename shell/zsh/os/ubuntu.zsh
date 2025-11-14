# Ubuntu固有のパス設定
export PATH="$HOME/.local/bin:$PATH"

# swiftly
. ~/.local/share/swiftly/env.sh

# Ubuntu固有のエイリアス
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

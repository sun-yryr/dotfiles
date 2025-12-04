# macOS固有のパス設定
export PATH="/opt/homebrew/bin:$PATH"
eval "$(brew shellenv)"

# psqlなど
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# swiftly
. ~/.swiftly/env.sh

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

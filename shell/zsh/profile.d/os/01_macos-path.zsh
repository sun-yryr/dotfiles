# macOS固有のパス設定
export PATH="/opt/homebrew/bin:$PATH"
eval "$(brew shellenv)"

# psqlなど
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# swiftly
if [ -f "~/.swiftly/env.sh" ]; then
    . ~/.swiftly/env.sh
fi

# あれば
if [ -f "~/.orbstack/shell/init.zsh" ]; then
  # Added by OrbStack: command-line tools and integration
  # This won't be added again if you remove it.
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

# あれば
if [ -f "~/.lmstudio/bin" ]; then
  # Added by LM Studio CLI (lms)
  export PATH="$PATH:$HOME/.lmstudio/bin"
  # End of LM Studio CLI section
fi

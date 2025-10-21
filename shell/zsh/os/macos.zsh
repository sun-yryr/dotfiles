# macOS固有のパス設定
export PATH="/opt/homebrew/bin:$PATH"
export ZPLUG_HOME=$(brew --prefix)/opt/zplug

# macOS固有のエイリアス
alias finder='open .'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# 基本設定
setopt autocd
setopt extendedglob
unsetopt beep
bindkey -e

# 補完システムを有効にする
autoload -Uz compinit
compinit

# プロンプトの設定
autoload -Uz promptinit
promptinit

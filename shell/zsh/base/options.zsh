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
# 同じコマンドを履歴に追加しない
setopt hist_ignore_all_dups

# プロンプトの設定
autoload -Uz promptinit
promptinit

# bashの補完を使ってみる
autoload -Uz bashcompinit
bashcompinit

source <(ghr shell bash --completion)
complete -C "$(which aws_completer)" aws

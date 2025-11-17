source $HOME/.zplug/init.zsh

# ------------------------------------------------------------
# プラグイン定義
# ------------------------------------------------------------
zplug "b4b4r07/enhancd", use:init.sh
# before any calls to compdef
zplug "marlonrichert/zsh-autocomplete", use:zsh-autocomplete.plugin.zsh
zplug "zsh-users/zsh-autosuggestions", use:zsh-autosuggestions.zsh

# ------------------------------------------------------------
# プラグインのインストールと読み込み
# ------------------------------------------------------------
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

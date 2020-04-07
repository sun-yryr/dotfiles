# macOS 用環境構築スクリプト

# やること
# - brew 各位のインストール
# - python 環境構築
# - xonsh 構築
# - powerline 用フォントのインストール
# - シンボリックリンクを貼る


# xonsh 環境構築
# 以下は pip が入っていることが前提
echo "xonsh..."
# prompt-toolkit はバグがあるので sun-yryrからインストールする
pip install gnureadline xonsh Pygments xontrib-z git+https://github.com/sun-yryr/python-prompt-toolkit.git git+https://github.com/sun-yryr/xontrib-powerline2.git
#brew install peco

# フォントインストール
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts; ./install.sh RobotoMono && cd ../; rm -rf nerd-fonts

# シンボリックリンクを貼る
rm $HOME/.xonshrc ; ln -s .xonshrc $HOME/.xonshrc

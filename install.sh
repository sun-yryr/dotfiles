# macOS 用環境構築スクリプト

# やること
# - brew 各位のインストール
# - python 環境構築
# - xonsh 構築
# - powerline 用フォントのインストール
# - シンボリックリンクを貼る

DIR_PATH=$(cd $(dirname $0); pwd)

# brew install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew 関連ソフト install
brew bundle --file ./Brewfile
# nodebrew Path
export PATH=$HOME/.nodebrew/current/bin:$PATH
source ~/.bash_profile

# mac preference
# trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad UserPreferences 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad version 5

# Dock
# Automatically hide or show the Dock （Dock を自動的に隠す）
defaults write com.apple.dock autohide -bool true
# Wipe all app icons from the Dock （Dock に標準で入っている全てのアプリを消す、Finder とごみ箱は消えない）
defaults write com.apple.dock persistent-apps -array
# Set the icon size （アイコンサイズの設定）
defaults write com.apple.dock tilesize -int 38
# Magnificate the Dock （Dock の拡大機能を入にする）
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 65
# Dock の再起動
# killall Dock

# Finder
# Automatically open a new Finder window when a volume is mounted
# マウントされたディスクがあったら、自動的に新しいウィンドウを開く
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Set `${HOME}` as the default location for new Finder windows
# 新しいウィンドウでデフォルトでホームフォルダを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Other
# Avoid creating `.DS_Store` files on network volumes （ネットワークディスクで、`.DS_Store` ファイルを作らない）
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Hide the battery percentage from the menu bar （バッテリーのパーセントを非表示にする）
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# Date options: Show the day of the week: on （日付表示設定、曜日を表示）
defaults write com.apple.menuextra.clock 'DateFormat' -string 'M\\U6708d\\U65e5(EEE)  H:mm:ss'

# Python 環境構築
# TODO: LTSをインストールできるようにする
pyenv install 3.8.2
pyenv global 3.8.2
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
source ~/.bash_profile


# xonsh 環境構築
# 以下は pip が入っていることが前提
echo "xonsh..."
# prompt-toolkit はバグがあるので sun-yryrからインストールする
pip install gnureadline xonsh Pygments xontrib-z git+https://github.com/sun-yryr/python-prompt-toolkit.git git+https://github.com/sun-yryr/xontrib-powerline2.git

# フォントインストール
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts; ./install.sh RobotoMono && cd ../; rm -rf nerd-fonts

# シンボリックリンクを貼る
ln -sf "$DIR_PATH/.xonshrc" $HOME

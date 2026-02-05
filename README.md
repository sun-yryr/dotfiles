# dotfiles

1. [Homebrew](https://brew.sh/ja/) をインストールする
1. Homebrewで[`gh`](https://cli.github.com/) コマンドをインストールする

   ```sh
   brew install gh
   ```

1. `gh auth login` でGitHubにログインする
1. このリポジトリを `~/Documents` にクローンする

   ```sh
   cd ~/Documents
   gh repo clone sun-yryr/dotfiles
   ```

1. `install.sh` を実行する

   ```sh
   cd dotfiles
   ./install.sh
   ```

## gpgのセットアップ

brewを復活させた後に

```sh
mkdir -p ~/.gnupg
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
```

## macのセットアップ

dockを消す
3本指でドラッグ

```sh
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize -int 38
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 65
defaults write com.apple.Dock autohide-delay -float 10
killall Dock
```


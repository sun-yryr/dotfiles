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

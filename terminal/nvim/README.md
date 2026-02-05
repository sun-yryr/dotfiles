# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 依存

- [skanehira/version-lsp](https://github.com/skanehira/version-lsp)
  - `mise use -g github:skanehira/version-lsp` などで入れておく

## 変更点

- terminal をフローティング表示に変更: [snacks.lua](https://github.com/sun-yryr/dotfiles/blob/736b06b99c47e663cdacb852c745d468fa4be3ae/terminal/nvim/lua/plugins/snacks.lua)
- explorer などで隠しファイルをデフォルトで表示、fuzzy matching: 2580dfe5d1f0
- explorer でignoreをグレーに、隠しファイルは通常のカラーに: a75652d9598a
- inlay hint 一旦全出しよね: 59a51001836c

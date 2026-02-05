# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 依存

- [skanehira/version-lsp](https://github.com/skanehira/version-lsp)
  - `mise use -g github:skanehira/version-lsp` などで入れておく

## 変更点

- terminal をフローティング表示に変更: [snacks.lua](https://github.com/sun-yryr/dotfiles/blob/736b06b99c47e663cdacb852c745d468fa4be3ae/terminal/nvim/lua/plugins/snacks.lua)
- explorer などで隠しファイルをデフォルトで表示、fuzzy matching: 2580dfe5d1f0a960394b7dc49c598c05b757654f
- explorer でignoreをグレーに、隠しファイルは通常のカラーに: a75652d9598a8fd42b860ab67b19df2172dc3ec5
- inlay hint 一旦全出しよね: 59a51001836c25e90b8b46b04e872b50f7508998
- version-lsp: e831ab2ba33bb381c17d88acdf56dc28951c94ea

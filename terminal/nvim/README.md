# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 依存

- [skanehira/version-lsp](https://github.com/skanehira/version-lsp)
  - `mise use -g github:skanehira/version-lsp` などで入れておく

## 変更点

- terminal はフローティング表示: [snacks.lua](https://github.com/sun-yryr/dotfiles/blob/736b06b99c47e663cdacb852c745d468fa4be3ae/terminal/nvim/lua/plugins/snacks.lua)
- explorer, files, grep の隠しファイルの挙動と fuzzy matching を設定: [commit](https://github.com/sun-yryr/dotfiles/commit/2580dfe5d1f0a960394b7dc49c598c05b757654f)
- explorer の色調整。ignoreだけグレーにする: [commit](https://github.com/sun-yryr/dotfiles/commit/a75652d9598a8fd42b860ab67b19df2172dc3ec5)
- inlay hint を一旦全出しする: [commit](https://github.com/sun-yryr/dotfiles/commit/59a51001836c25e90b8b46b04e872b50f7508998)
- version-lsp を追加: [commit](https://github.com/sun-yryr/dotfiles/commit/e831ab2ba33bb381c17d88acdf56dc28951c94ea)

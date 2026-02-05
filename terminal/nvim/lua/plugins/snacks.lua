return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        position = "float",
      },
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          matcher = {
            fuzzy = true,
          },
        },
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
}

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
        },
        files = {
          hidden = true,
          matcher = {
            fuzzy = true,
          },
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
}

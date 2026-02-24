return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        swift = { "swiftlint" },
      }

      local g = vim.api.nvim_create_augroup("LintSwift", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = g,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

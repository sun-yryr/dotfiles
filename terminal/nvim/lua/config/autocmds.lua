-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    Snacks.util.set_hl({
      PickerPathHidden = { link = "Text" },
      PickerPathIgnored = { link = "Comment" },
    }, { prefix = "Snacks" })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    -- LSPクライアントごとのdiagnostics namespaceを取得
    local ns = vim.lsp.diagnostic.get_namespace(client.id)
    -- version-lsp の diagnostics だけ表示設定を変える
    if client.name == "version_lsp" then
      vim.diagnostic.config({
        virtual_text = true,
        underline = false,
      }, ns)
    end
  end,
})

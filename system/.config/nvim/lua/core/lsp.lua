-- How Neovim's built-in LSP client behaves. Where servers come from is plugins/lsp.lua's job.

-- Per-server settings, merged over nvim-lspconfig's recipes (vim.lsp.config always wins)
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,                 -- ruff organises imports
      analysis = { typeCheckingMode = "standard" },  -- see note below
    },
  },
})

vim.lsp.config("tinymist", {
  settings = { formatterMode = "typstyle" },  -- used for formatting in step 6
})

-- Diagnostics: since 0.11, messages aren't shown inline unless you ask
vim.diagnostic.config({
  virtual_text = { source = "if_many" },  -- message at line end, tagged with which tool raised it
  float = { source = "if_many" },
  severity_sort = true,                   -- errors before warnings
})

-- Runs every time a server attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Two Python servers: basedpyright answers K; ruff sticks to linting and formatting
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    local function map(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("<leader>th", function()
      local on = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
      vim.lsp.inlay_hint.enable(not on, { bufnr = args.buf })
    end, "Toggle inlay hints")
  end,
})

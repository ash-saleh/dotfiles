return {
  "stevearc/conform.nvim",
  event = "BufWritePre",  -- load just before the first save
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true }) end,
      mode = { "n", "x" },
      desc = "Format buffer (or selection)",
    },
    {
      "<leader>tf",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
      end,
      desc = "Toggle format on save",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { "ruff_organize_imports", "ruff_format" },  -- run in order: sort imports, then format
      typst = { lsp_format = "prefer" },                     -- hand Typst to tinymist (typstyle)
    },
    format_on_save = function(bufnr)
      -- Skip when toggled off, or for filetypes with no formatter chosen above
      if vim.g.disable_autoformat or not require("conform").formatters_by_ft[vim.bo[bufnr].filetype] then
        return
      end
      return { timeout_ms = 500 }
    end,
  },
}

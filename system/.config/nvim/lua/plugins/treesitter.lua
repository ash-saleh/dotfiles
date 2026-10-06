return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",      -- the rewrite; already the default, stated because most examples online say master
  lazy = false,         -- this plugin doesn't support lazy-loading
  build = ":TSUpdate",  -- rebuild parsers whenever the plugin updates
  config = function()
    require("nvim-treesitter").install({
      "python", "typst", "lua",
      "toml", "bash", "json", "yaml",
      "markdown", "markdown_inline",
    })

    -- Start treesitter highlighting in any buffer whose filetype has a parser
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),  -- never registered twice
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)  -- pcall: most filetypes (lazy, netrw...) have no parser
      end,
    })
  end,
}

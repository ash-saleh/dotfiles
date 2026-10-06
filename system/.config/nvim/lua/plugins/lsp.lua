return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },  -- load when you open a file, not at startup
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },  -- :Mason works before any file is open
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- lspconfig names: Mason installs any that are missing, then each gets vim.lsp.enable()
      ensure_installed = { "basedpyright", "ruff", "tinymist", "lua_ls" },
    },
  },

  -- Teaches lua_ls about Neovim's API and your plugins, so the config itself gets completion
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

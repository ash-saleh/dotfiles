return {
{
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      {
        "neovim/nvim-lspconfig",
        config = function()
          -- Toolchain list: servers installed by a language's own toolchain.
          -- Mason can't see these, so they're switched on by hand.
          vim.lsp.enable({ "hls" })
        end,
      },
    },
    opts = {
      -- Mason list: installed by Mason if missing, then switched on
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

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    theme = "dragon",
    background = { dark = "dragon", light = "lotus" },  -- see below
    colors = {
      theme = { all = { ui = { bg_gutter = "none" } } },  -- gutter blends into the background
    },
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}

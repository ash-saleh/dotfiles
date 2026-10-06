return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },  -- file-type icons
  opts = {
    options = {
      theme = "auto",       -- take colours from the active colour scheme
      globalstatus = true,  -- one statusline across the bottom, not one per split
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },  -- path relative to the working directory
      lualine_x = { "lsp_status", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "lazy", "mason", "quickfix" },  -- tidy statuslines in those windows
  },
}

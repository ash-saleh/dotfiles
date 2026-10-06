-- Search hidden paths (your config lives under .config/), but never inside .git or .venv
local rg_args = { "--hidden", "--glob", "!**/.git/*", "--glob", "!**/.venv/*" }

return {
  "nvim-telescope/telescope.nvim",
  version = "*",  -- latest release, as the README recommends
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },  -- compiled sorter, much faster
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep the project" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Neovim help" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search keymaps" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",               -- best match at the top...
        layout_config = { prompt_position = "top" },  -- ...right under where you type
        mappings = {
          i = { ["<Esc>"] = actions.close },           -- one Esc closes, not two
        },
      },
      pickers = {
        find_files = { find_command = vim.list_extend({ "rg", "--files" }, rg_args) },
        live_grep = { additional_args = rg_args },
        grep_string = { additional_args = rg_args },
      },
    })
    telescope.load_extension("fzf")
  end,
}

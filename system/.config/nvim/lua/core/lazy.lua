-- Bootstrap: clone lazy.nvim the first time Neovim starts on a machine
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },            -- every file in lua/plugins/
  install = { colorscheme = { "habamax" } },    -- built-in scheme used before yours is installed
  checker = { enabled = true, notify = false }, -- check for updates quietly; :Lazy shows them
  change_detection = { notify = false },        -- no popup every time you save a config file
  rocks = { enabled = false },                  -- none of these plugins need luarocks
  performance = {
    rtp = {
      -- built-in plugins you won't use; netrw stays because <leader>e needs it
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

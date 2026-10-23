-- Runs every time a Typst buffer opens; everything here applies to .typ files only.
-- after/ means it runs after Neovim's own Typst settings, so these win.

vim.opt_local.shiftwidth = 2      -- Typst's usual 2-space indent
vim.opt_local.tabstop = 2
vim.opt_local.spell = true        -- prose and comments only; math and code are skipped
vim.opt_local.spelllang = "en_gb"

-- \p: open this file's PDF (tinymist writes it on every save)
vim.keymap.set("n", "<localleader>p", function()
  local pdf = vim.fn.expand("%:p:r") .. ".pdf"
  if vim.fn.filereadable(pdf) == 0 then
    vim.notify("No PDF yet: save the file first", vim.log.levels.WARN)
    return
  end
  vim.system({ "zathura", pdf }, { detach = true })  -- detach: zathura outlives Neovim
end, { buffer = true, desc = "Open PDF in zathura" })

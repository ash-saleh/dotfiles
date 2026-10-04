-- Leader first: everything after this, including lazy.nvim, binds <leader> to Space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Numbers and gutter
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"      -- always reserve the gutter, so text doesn't shift when diagnostics appear
opt.cursorline = true

-- Indentation: 4 spaces; filetype rules adjust per language
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Wrapping stays on for Typst prose, breaking at word boundaries with indent kept
opt.linebreak = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true        -- ...until you type a capital letter
opt.inccommand = "split"    -- live preview of :s substitutions

-- Feel
opt.scrolloff = 8           -- keep 8 lines visible above and below the cursor
opt.splitright = true
opt.splitbelow = true
opt.undofile = true         -- undo history survives closing the file
opt.swapfile = false
opt.confirm = true          -- ask to save instead of refusing to quit
opt.updatetime = 250        -- faster CursorHold events (used later by LSP features)
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }  -- make stray whitespace visible

-- System clipboard. Deferred because the clipboard check is slow enough to show up in startup time.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

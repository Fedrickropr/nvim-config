vim.wo.number = true
vim.g.mouse = 'a'
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 7
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.fileformat = "unix"
vim.g.mapleader = " "

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 250 }
  end,
})

local keymap = vim.keymap.set
local opts = { silent = true }

keymap('n', '<leader>F', function()
  require('telescope.builtin').live_grep()
end, opts)

keymap('n', '<leader>fb', function()
  require('telescope.builtin').buffers()
end, opts)

keymap('n', '<leader>fh', function()
  require('telescope.builtin').help_tags()
end, opts)
keymap('n', '<C-p>', function()
    require('telescope.builtin').find_files()
end, opts)

keymap('n', '<leader>C', '<Cmd>BufferClose<CR>', { silent = true })
keymap('n', '<Tab>', '<Cmd>BufferNext<CR>', { silent = true })
keymap('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { silent = true })
keymap('n', '<leader>w', '<Cmd>NvimTreeToggle<CR>', { silent = true })
keymap('n', 'x', '"_x')
keymap({'n', 'i'}, '<C-c>', '<Esc>')

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))]],
      ["*"] = [[powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))]],
    },
    cache_enabled = 0,
  }
end


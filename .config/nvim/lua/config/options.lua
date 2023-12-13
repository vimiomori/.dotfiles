-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
vim.opt.backupdir = os.getenv("$HOME") .. "/.vim/backup"
vim.opt.directory = os.getenv("$HOME") .. "/.vim/swap"
vim.opt.undodir = os.getenv("$HOME") .. "/.vim/undo"

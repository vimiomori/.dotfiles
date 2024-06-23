-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("BufNewFile", {
  command = "Neorg templates load journal",
  pattern = { "~/code/src/github.com/vimiomori/cyber-dolphin/daily/**/*.norg" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    vim.o.conceallevel = 3

    -- local maps = { n = {}, i = {} }
    --
    -- maps.n["<leader>ni"] = { desc = "Insert Links" }
    --
    -- maps.n["<leader>nn"] = { "<cmd>Neorg keybind all core.dirman.new.note<cr>", desc = "New Note" }
    -- maps.n["<leader>ns"] = { "<cmd>Neorg generate-workspace-summary<cr>", desc = "Summary" }
    -- maps.n["<leader>nc"] =
    --   { "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>", desc = "Looking Glass" }
    -- maps.n["<leader>nT"] = { "<cmd>Neorg toc<cr>", desc = "Table of Contents" }
    --
    -- maps.n["<leader>ne"] = { desc = "Export" }
    -- maps.n["<leader>nec"] = { "<cmd>Neorg tangle current-file<cr>", desc = "Code Blocks" }
    -- maps.n["<leader>nef"] = { "<cmd>Neorg export to-file<cr>", desc = "Export File" }
    -- maps.n["<leader>ned"] = { "<cmd>Neorg export directory notes markdown output<cr>", desc = "Export Directory" }
    --
    -- maps.n["<leader>nt"] = { desc = "Todos" }
    -- maps.n["<leader>ntd"] = { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_done<cr>", desc = "Task Done" }
    -- maps.n["<leader>ntu"] = { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_undone<cr>", desc = "Task Undone" }
    -- maps.n["<leader>ntp"] =
    --   { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_pending<cr>", desc = "Task Pending" }
    -- maps.n["<leader>nto"] =
    --   { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_on_hold<cr>", desc = "Task On Hold" }
    -- maps.n["<leader>ntc"] =
    --   { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_cancelled<cr>", desc = "Task Cancelled" }
    -- maps.n["<leader>ntr"] =
    --   { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_recurring<cr>", desc = "Task Recurring" }
    -- maps.n["<leader>nti"] =
    --   { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_important<cr>", desc = "Task Important" }
    --
    -- maps.n["<C-;>"] = { "<cmd>Neorg keybind all core.itero.next-iteration<cr>" }
    -- maps.i["<C-;>"] = { "<cmd>Neorg keybind all core.itero.next-iteration<cr>" }
    --
    -- maps.n["<leader>nm"] = { desc = "Modes" }
    -- maps.n["<leader>nmn"] = { "<cmd>Neorg mode norg<cr>", desc = "Norg" }
    -- maps.n["<leader>nmh"] = { "<cmd>Neorg mode norg<cr>", desc = "Heading" }
    --
    -- maps.n["<leader>nd"] = { "<cmd>Neorg keybind all core.tempus.insert-date<cr>", desc = "Insert Date" }
    --
    -- maps.n["<leader>nl"] = { desc = "Lists" }
    -- maps.n["<leader>nlt"] = { "<cmd>Neorg keybind all core.pivot.toggle-list-type<cr>", desc = "Toggle" }
    -- maps.n["<leader>nli"] = { "<cmd>Neorg keybind all core.pivot.invert-list-type<cr>", desc = "Invert" }
    --
    -- require("astronvim.utils").set_mappings(maps)
  end,
})

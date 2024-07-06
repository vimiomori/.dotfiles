-- local utils = require("extras.neorg.utils")
return {
  {
    "tools-life/taskwiki",
  },
  { "farseer90718/vim-taskwarrior" },
  { "majutsushi/tagbar" },
  { "powerman/vim-plugin-AnsiEsc" },
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        { path = "~/code/src/github.com/vimiomori/cyber-dolphin" },
        -- { path = '~/code/src/github.com/vimiomori/cyber-dolphin/home', syntax = 'markdown', ext = '.md', links_space_char = '-' },
      }
      vim.g.vimwiki_use_mouse = 1
      vim.g.vimwiki_map_prefix = "<leader>v"
    end,
    keys = {
      { "<leader>vv", "<plug>VimwikiIndex", desc = "Open VimWiki index" },
      { "<leader>vdd", "<plug>VimwikiMakeDiaryNote", desc = "Make diary note" },
      { "<leader>vdt", "<plug>VimwikiTabMakeDiaryNote", desc = "Make diary note in new tab" },
      { "<leader>vdi", "<plug>VimwikiDiaryGenerateLinks", desc = "Generate diary links" },
      { "<leader>vdn", "<plug>VimwikiMakeTomorrowDiaryNote", desc = "Make diary note for tomorrow" },
      { "<leader>vdp", "<plug>VimwikiMakeYesterdayDiaryNote", desc = "Make diary note for yesterday" },
    },
  },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1000,
  --   config = true,
  -- },
  -- {
  --   "nvim-neorg/neorg",
  --   dependencies = {
  --     "luarocks.nvim",
  --     { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
  --   },
  --   lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  --   version = "*", -- Pin Neorg to the latest stable release
  --   config = function()
  --     require("neorg").setup({
  --       load = {
  --         ["core.defaults"] = {},
  --         ["core.concealer"] = {
  --           config = {
  --             icon_preset = "diamond",
  --             icons = {
  --               heading = {
  --                 icons = { "◆", "❖", "◈", "◇", "⟡", "⋄" },
  --               },
  --             },
  --           },
  --         },
  --         ["core.autocommands"] = {},
  --         ["core.journal"] = {
  --           config = {
  --             workspace = "notes",
  --             journal_folder = "daily",
  --             strategy = "nested",
  --           },
  --           -- template_name = "daily_template.norg"
  --         },
  --         ["external.templates"] = {
  --           config = {
  --             templates_dir = "~/code/src/github.com/vimiomori/cyber-dolphin/templates",
  --             -- default_subcommand = "add", -- or "fload", "load"
  --             keywords = {
  --               TODAY_TITLE = function()
  --                 local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
  --                 local date = os.date("%A %B %d, %Y", os.time({ year = buf[1], month = buf[2], day = buf[3] }))
  --                 return require("luasnip").text_node(date)
  --               end,
  --               YESTERDAY_PATH = function()
  --                 local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
  --                 local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
  --                 local yesterday = os.date("%Y/%m/%d", time - 86400)
  --                 return require("luasnip").text_node(("../../%s"):format(yesterday))
  --               end,
  --               TOMORROW_PATH = function()
  --                 local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
  --                 local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
  --                 local tomorrow = os.date("%Y/%m/%d", time + 86400)
  --                 return require("luasnip").text_node(("../../%s"):format(tomorrow))
  --               end,
  --               CARRY_OVER_TODOS = function()
  --                 -- local todos = table.concat(get_carryover_todos(), "\n")
  --                 return require("luasnip").text_node(utils.get_carryover_todos())
  --               end,
  --             },
  --           },
  --           -- snippets_overwrite = {},
  --         },
  --         -- ["core.presenter"] = {
  --         --   config = {
  --         --     zen_mode = "truezen",
  --         --   },
  --         -- },
  --         ["core.dirman"] = {
  --           config = {
  --             workspaces = {
  --               notes = "~/code/src/github.com/vimiomori/cyber-dolphin",
  --             },
  --             autochdir = true,
  --             default_workspace = "notes",
  --           },
  --         },
  --         ["core.completion"] = {
  --           config = {
  --             engine = "nvim-cmp",
  --           },
  --         },
  --         ["core.keybinds"] = {
  --           config = {
  --             default_keybinds = true,
  --             hook = function(keybinds)
  --               -- Unmaps any Neorg key from the `norg` mode
  --               -- keybinds.unmap("norg", "n", "gtd")
  --               -- keybinds.unmap("norg", "n", keybinds.leader .. "nn")
  --
  --               -- Binds the `gtd` key in `norg` mode to execute `:echo 'Hello'`
  --               -- keybinds.map("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
  --
  --               -- Remap unbinds the current key then rebinds it to have a different action
  --               -- associated with it.
  --               -- The following is the equivalent of the `unmap` and `map` calls you saw above:
  --               -- keybinds.remap("norg", "n", "gtd", "<cmd>echo 'Hello!'<CR>")
  --
  --               -- Sometimes you may simply want to rebind the Neorg action something is bound to
  --               -- versus remapping the entire keybind. This remap is essentially the same as if you
  --               -- did `keybinds.remap("norg", "n", "<C-Space>, "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>")
  --               keybinds.remap_event("norg", "n", "<Leader>ntd", "core.qol.todo_items.todo.task_done")
  --               keybinds.remap_event("norg", "n", "<Leader>ntu", "core.qol.todo_items.todo.task_undone")
  --
  --               -- Want to move one keybind into the other? `remap_key` moves the data of the
  --               -- first keybind to the second keybind, then unbinds the first keybind.
  --               -- keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>t")
  --             end,
  --           },
  --         },
  --       },
  --     })
  --     -- local neorg_callbacks = require "neorg.core.callbacks"
  --     --
  --     -- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
  --     --   -- Map all the below keybinds only when the "norg" mode is active
  --     --   keybinds.map_event_to_mode("norg", {
  --     --     n = { -- Bind keys in normal mode
  --     --       { "<localleader>fl", "core.integrations.telescope.find_linkable" },
  --     --       { "<localleader>fb", "core.integrations.telescope.find_backlinks" },
  --     --       { "<localleader>fh", "core.integrations.telescope.find_header_backlinks" },
  --     --     },
  --     --
  --     --     i = { -- Bind in insert mode
  --     --       { "<localleader>li", "core.integrations.telescope.insert_link" },
  --     --     },
  --     --   }, {
  --     --     silent = true,
  --     --     noremap = true,
  --     --   })
  --     -- end)
  --
  --     utils.template("*/daily/*.norg", "journal")
  --   end,
  --   keys = {
  --     { "<leader>nn", "<cmd>Neorg journal today<cr>", desc = "New daily note" },
  --     { "<leader>nw", "<cmd>Neorg workspace notes<cr>", desc = "Open notes workespace" },
  --   },
  -- },
}

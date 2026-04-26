return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- {
  --   "hedyhli/markdown-toc.nvim",
  --   ft = "markdown", -- Lazy load on markdown filetype
  --   cmd = { "Mtoc" },
  --   opts = {
  --     {
  --       headings = {
  --         -- Include headings before the ToC (or current line for `:Mtoc insert`).
  --         -- Setting to true will include headings that are defined before the ToC
  --         -- position to be included in the ToC.
  --         before_toc = false,
  --       },
  --
  --       -- Table or boolean. Set to true to use these defaults, set to false to disable completely.
  --       -- Fences are needed for the update/remove commands, otherwise you can
  --       -- manually select ToC and run update.
  --       fences = {
  --         enabled = true,
  --         -- These fence texts are wrapped within "<!-- % -->", where the '%' is
  --         -- substituted with the text.
  --         start_text = "mtoc-start",
  --         end_text = "mtoc-end",
  --         -- An empty line is inserted on top and below the ToC list before the being
  --         -- wrapped with the fence texts, same as vim-markdown-toc.
  --       },
  --
  --       -- Enable auto-update of the ToC (if fences found) on buffer save
  --       auto_update = true,
  --
  --       toc_list = {
  --         -- string or list of strings (for cycling)
  --         -- If cycle_markers = false and markers is a list, only the first is used.
  --         -- You can set to '1.' to use a automatically numbered list for ToC (if
  --         -- your markdown render supports it).
  --         markers = "*",
  --         cycle_markers = false,
  --         -- Example config for cycling markers:
  --         ----- markers = {'*', '+', '-'},
  --         ----- cycle_markers = true,
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = false,
  --   opts = {
  --     linters = {
  --       markdownlint = {
  --         args = { "--disable", "MD013", "--" },
  --       },
  --       ["markdownlint-cli2"] = {
  --         args = { "--config", "/Users/vivian.hsieh/.markdownlint-cli2.yaml", "--" },
  --       },
  --     },
  --   },
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = "obsidian",
      inline_highlight = {
        enabed = false,
      },
      code = {
        enabled = false,
        conceal_delimiters = false,
        language = false,
        disable_background = true,
      },
      html = {
        comment = {
          conceal = false,
        },
      },
      anti_conceal = {
        enabled = true,
        above = 3,
        below = 3,
      },
    },
  },
}

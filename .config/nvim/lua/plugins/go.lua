return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_inlay_hints = {enable = true, style = 'eol'},
        run_in_floaterm = true,
      })
    end,
    -- keys = {
    --   { "<leader>tf", "<cmd>GoTestFunc<cr>", desc = "Test current function" },
    --   { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    -- },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- {
  --   "fatih/vim-go",
  -- },
  {
    "nvim-neotest/neotest",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          settings = {
            hints = {},
            gopls = {
              analyses = {
                fieldalignment = false,
                unusedparams = false,
              },
            },
          },
        },
        golangcilsp = {},
      },
      setup = {
        golangcilsp = function()
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")

          if not configs.golangcilsp then
            configs.golangcilsp = {
              default_config = {
                cmd = { "golangci-lint-langserver" },
                root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
                filetypes = { "go" },
                init_options = {
                  command = {
                    "golangci-lint",
                    "run",
                    "--out-format",
                    "json",
                    "--issues-exit-code=1",
                  },
                },
              },
            }
          end
          -- lspconfig.gopls.setup({})
          lspconfig.golangcilsp.setup({})
        end,
      },
    },
  },
}

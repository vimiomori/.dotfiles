return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "fatih/vim-go",
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
    },
  },
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
    opts = function(_, opts)
      opts.servers.gopls.settings.gopls.analyses.fieldalignment = false
      opts.format.timeout_ms = 10000
    end,
  },
}

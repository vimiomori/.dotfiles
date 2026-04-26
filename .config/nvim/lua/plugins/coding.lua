return {
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  {
    "Saghen/blink.cmp",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = function()
      return { "LazyFile" }
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "gofumpt",
        "black",
        "mypy",
        "pyright",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "biome",
        "markdownlint-cli2",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = { "VeryLazy" },
    keys = {
      {
        "<leader>ci",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      default_format_opts = {
        async = true,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        go = { "goimports" },
        python = { "black" },
        javascript = { "prettier" },
        markdown = { "markdownlint-cli2" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<C-s>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    },
    opts = function(_, opts)
      opts.window.mappings["<cr>"] = "rename"
      opts.window.mappings["o"] = "open"
    end,
  },
}

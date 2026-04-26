return {
  {
    "vimiomori/bluedolphin.nvim",
    opts = {
      transparent = true,
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "normal", -- style for sidebars, see below
        floats = "normal", -- style for floating windows
        bufferline = "dark", -- style for floating windows
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "bluedolphin",
    },
  },
}

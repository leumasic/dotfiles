return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "arzg/vim-colors-xcode",
    lazy = true,
  },
  {
    "sainnhe/sonokai",
    -- lazy = true,
    config = function()
      -- Custom colors
      vim.g.sonokai_colors_override = {
        bg0 = { "#16171D", "233" },
        bg3 = { "#1a1b1e", "237" },
        red = { "#FF3F4F", "167" },
        -- orange = { "#19D1E5", "208" },
        -- yellow = { "#eba721", "214" },
        green = { "#81F900", "142" },
        -- aqua = { "#89ad7d", "108" },
        blue = { "#19D1E5", "109" },
        purple = { "#E373CE", "175" },
      }
    end,
  },
  {
    "sainnhe/everforest",
    lazy = true,
  },
}

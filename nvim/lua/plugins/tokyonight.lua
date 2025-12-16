return {
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    style = "night", -- choose a style: "night", "storm", "moon", or "day"
    -- Other options can be added here, see the documentation for details
  },
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}


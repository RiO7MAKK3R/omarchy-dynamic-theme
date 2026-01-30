return {
  {
    "LazyVim/LazyVim",
    lazy = false,
    priority = 1000,
    config = function()
      local colors = {
        bg        = "#000000", -- pure black
        fg        = "#FFFFFF", -- pure white
        gray      = "#888888", -- neutral gray for comments/line numbers
      }

      vim.cmd("highlight clear")
      vim.cmd("set termguicolors")

      -- Basic text
      vim.api.nvim_set_hl(0, "Normal",      { fg = colors.fg, bg = colors.bg })
      vim.api.nvim_set_hl(0, "Comment",     { fg = colors.gray, italic = true })
      vim.api.nvim_set_hl(0, "Constant",    { fg = colors.fg })
      vim.api.nvim_set_hl(0, "String",      { fg = colors.fg })
      vim.api.nvim_set_hl(0, "Number",      { fg = colors.fg })
      vim.api.nvim_set_hl(0, "Boolean",     { fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "Identifier",  { fg = colors.fg })
      vim.api.nvim_set_hl(0, "Function",    { fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "Statement",   { fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "Keyword",     { fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "Type",        { fg = colors.fg })
      vim.api.nvim_set_hl(0, "Special",     { fg = colors.fg })

      -- UI
      vim.api.nvim_set_hl(0, "CursorLine",  { bg = "#111111" })
      vim.api.nvim_set_hl(0, "CursorLineNr",{ fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "LineNr",      { fg = colors.gray })
      vim.api.nvim_set_hl(0, "Visual",      { bg = "#222222" })
      vim.api.nvim_set_hl(0, "Search",      { fg = colors.bg, bg = colors.fg })
      vim.api.nvim_set_hl(0, "IncSearch",   { fg = colors.bg, bg = colors.fg })
      vim.api.nvim_set_hl(0, "Pmenu",       { fg = colors.fg, bg = "#111111" })
      vim.api.nvim_set_hl(0, "PmenuSel",    { fg = colors.bg, bg = colors.fg })
      vim.api.nvim_set_hl(0, "StatusLine",  { fg = colors.fg, bg = "#111111" })
      vim.api.nvim_set_hl(0, "StatusLineNC",{ fg = colors.gray, bg = "#111111" })
      vim.api.nvim_set_hl(0, "VertSplit",   { fg = "#333333" })
      vim.api.nvim_set_hl(0, "Title",       { fg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "ErrorMsg",    { fg = colors.bg, bg = colors.fg, bold = true })
      vim.api.nvim_set_hl(0, "WarningMsg",  { fg = colors.bg, bg = colors.gray })
    end,
  },
}

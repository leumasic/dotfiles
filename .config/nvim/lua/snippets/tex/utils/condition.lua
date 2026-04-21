local M = {}

-- Treesitter-based math zone detection for markdown.
-- Walks up the TS node tree from the cursor, checking for math-related node types.
local function in_mathzone_ts()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1 -- convert to 0-indexed

  local ok, parser = pcall(vim.treesitter.get_parser, buf, "markdown_inline")
  if not ok or not parser then
    return false
  end

  local tree = parser:parse()[1]
  if not tree then
    return false
  end

  local node = tree:root():named_descendant_for_range(row, col, row, col)

  -- Walk up the tree checking node types
  while node do
    local t = node:type()
    if t == "latex_block" or t == "latex_span_delimiter" or t == "inline_formula" then
      return true
    end
    node = node:parent()
  end
  return false
end

M.in_mathzone = function()
  if vim.bo.filetype == "markdown" then
    return in_mathzone_ts()
  end
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
M.in_text = function()
  return not M.in_mathzone()
end
M.in_comment = function()
  if vim.bo.filetype == "markdown" then
    return false
  end
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

local function in_env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

M.in_preamble = function()
  return not in_env("document")
end

M.in_itemize = function() -- itemize environment detection
  return in_env("itemize")
end
M.in_tikz = function() -- TikZ picture environment detection
  return in_env("tikzpicture")
end

M.in_align = function() -- align environment detection
  return in_env("align") or in_env("align*")
end

M.in_equation = function() -- equation environment detection
  return in_env("equation") or in_env("equation*")
end

return M

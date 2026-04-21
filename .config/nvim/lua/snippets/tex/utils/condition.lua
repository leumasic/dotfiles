local M = {}

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
  math_environment = true,
}

local function in_mathzone_ts()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  while node do
    if node:type() == "text_mode" then
      return false
    elseif MATH_NODES[node:type()] then
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

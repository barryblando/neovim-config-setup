local ok_status, signature = pcall(require, "lsp_signature")

if not ok_status then
  return
end

signature.setup {
  -- general options
    -- general options
  always_trigger = true,
  hint_enable = false, -- virtual text hint

  -- floating window
  padding = " ",
  transparency = nil,
  handler_opts = {
    border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
  },
}


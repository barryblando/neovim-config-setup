local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- TODO: backfill this to template
M.setup = function()
  local icons = require "plugins.icons"

  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      show_header = true,
      source = "always",
      focusable = false,
    },
  }

  vim.diagnostic.config(config)

  -- Hover rounded border with transparency effect from cmp
  local function custom_handler(handler)
    local overrides = { border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" } }
    -- border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
    return vim.lsp.with(function(...)
      local buf, winnr = handler(...)
      if buf then
        -- use the same transparency effect from cmp
        vim.api.nvim_win_set_option(winnr, 'winhighlight', 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None')
      end
    end, overrides)
  end

  -- https://neovim.io/doc/user/lsp.html
  vim.lsp.handlers["textDocument/hover"] = custom_handler(vim.lsp.handlers.hover)
  vim.lsp.handlers["textDocument/signatureHelp"] = custom_handler(vim.lsp.handlers.signature_help)

  -- wrapped open_float to inspect diagnostics and use the severity color for border
  -- https://neovim.discourse.group/t/lsp-diagnostics-how-and-where-to-retrieve-severity-level-to-customise-border-color/1679
  -- TODO: find a way to extract winnr to make transparency effect(not winblend) happen
  vim.diagnostic.open_float = (function(orig)
    return function(bufnr, opts)
      local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      local opts = opts or {}
      -- A more robust solution would check the "scope" value in `opts` to
      -- determine where to get diagnostics from, but if you're only using
      -- this for your own purposes you can make it as simple as you like
      local diagnostics = vim.diagnostic.get(opts.bufnr or 0, {lnum = lnum})
      local max_severity = vim.diagnostic.severity.HINT

      for _, d in ipairs(diagnostics) do
        -- Equality is "less than" based on how the severities are encoded
        if d.severity < max_severity then
            max_severity = d.severity
        end
      end

      local border_color = ({
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      })[max_severity]

      opts.border = {
        { "╔" , border_color },
        { "═" , border_color },
        { "╗" , border_color },
        { "║" , border_color },
        { "╝" , border_color },
        { "═" , border_color },
        { "╚" , border_color },
        { "║" , border_color },
      }

      orig(bufnr, opts)
    end
  end)(vim.diagnostic.open_float)

  -- Show line diagnostics in floating popup on hover, except insert mode (CursorHoldI)
  vim.o.updatetime = 250
  vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
end

-- local function lsp_highlight_document(client)
--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       hi! link LspReferenceRead Visual
--       hi! link LspReferenceText Visual
--       hi! link LspReferenceWrite Visual
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end

local function lsp_highlight_document(client)
  -- If you are on Neovim v0.8, use client.server_capabilities.documentHighlightProvider
  if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M

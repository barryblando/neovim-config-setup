local util = require'lspconfig'.util

return {
  -- denols will only resolve projects with the ff patterns
  root_dir = util.root_pattern("mod.ts", "mod.js", "deno.json", "deno.jsonc"),
}

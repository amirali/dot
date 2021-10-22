-- Setup LSP handlers to use fzf
local has_lspfuzzy, lspfuzzy = pcall(require, "lspfuzzy")
if not has_lspfuzzy then
  return
end
lspfuzzy.setup {}

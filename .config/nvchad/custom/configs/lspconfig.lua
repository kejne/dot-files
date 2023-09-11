local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "terraformls", "bashls", "bufls","csharp_ls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {"helm_ls", "serve"},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspconfig.helm_ls.setup {
  filetypes = {"helm"},
  cmd = {"helm_ls", "serve"},
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd_env = {GOFLAGS="-tags=integration"},
}

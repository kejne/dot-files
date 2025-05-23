local lspconfig = require 'lspconfig'

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'templ' },
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'templ' },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
  init_options = { userLanguages = { templ = 'html' } },
}

require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "eslint", "rust_analyzer", "processing" }



vim.lsp.config('processing', {
  cmd = { 'processing', 'lsp' },
  filetypes = { 'processing' }
  }
)


vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

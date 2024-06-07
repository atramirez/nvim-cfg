local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	'clangd',
	'pyright',
	'rust_analyzer',
	'lua_ls',
	},
  handlers = {
	function(server_name)
	  require('lspconfig')[server_name].setup({})
	end,
	},
})


local lsp = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')

lsp.preset('recommended')
lsp.setup()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
  },
})

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

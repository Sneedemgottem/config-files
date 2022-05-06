-- Plugins

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'voldikss/vim-floaterm'
Plug 'cdmedia/itg_flat_vim'
Plug 'tpope/vim-commentary'

-- LSP completion stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

vim.call('plug#end')


-- Global Configurations

local set = vim.opt
set.number = true

vim.cmd [[
	colorscheme itg_flat_transparent
]]

-- Float term
vim.g.floaterm_keymap_toggle = '<F12>'
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

-- Neovim LSP configs
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {'clangd'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = capabilities,
	}
end

local cmp = require('cmp')

cmp.setup {
	mapping = cmp.mapping.preset.insert({
	['<C-d>'] = cmp.mapping.scroll_docs(-4),

    	['<C-f>'] = cmp.mapping.scroll_docs(4),

    	['<C-Space>'] = cmp.mapping.complete(),

    	['<CR>'] = cmp.mapping.confirm {
      	behavior = cmp.ConfirmBehavior.Replace,
      	select = true,
    	},

    	['<Tab>'] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_next_item()
      		else
        		fallback()
      		end
    	end, { 'i', 's' }),

    	['<S-Tab>'] = cmp.mapping(function(fallback)
      		if cmp.visible() then
        		cmp.select_prev_item()
      		else
        		fallback()
      		end
    		end, { 'i', 's' }),
  	}),

	sources = {
		{name = 'nvim_lsp'},
	}
}

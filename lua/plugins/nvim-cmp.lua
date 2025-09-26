-- Neovim autocomplete
-- Very important to have snippet completion

-- Diagnostic column and some ms of no cursor movement to trigger CursorHold
vim.wo.signcolumn = 'yes'
vim.opt.updatetime = 300

return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-emoji',
		'L3MON4D3/LuaSnip',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-cmdline',
		'windwp/nvim-autopairs',
	},
	-- No lazy loading for autocomplete plugin
	opts = {
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		-- Installed sources
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'nvim_lua' },
			{ name = 'emoji' },
			{ name = 'luasnip' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'cmdline' },
			{ name = 'autopairs' },
		},
	},
	config = function(_, opts)
		local cmp = require('cmp')
		local wk = require('which-key')
		cmp.setup(opts)
		-- Set up autopairs
		cmp.event:on(
		  'confirm_done',
		  require('nvim-autopairs.completion.cmp').on_confirm_done()
		)

		wk.add({
			-- Note that calling each of these functions returns another function
			['<Tab>'] = { cmp.mapping.select_next_item(), 'Select Next' },
			['<S-Tab>'] = { cmp.mapping.select_prev_item(), 'Select Previous' },
			['<C-d>'] = { cmp.mapping.scroll_docs(-4), 'Scroll Down' },
			['<C-f>'] = { cmp.mapping.scroll_docs(4), 'Scroll Up' },
			['<C-e>'] = { cmp.mapping.close(), 'Close' },
			['<CR>'] = { cmp.mapping(
				function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if entry then
							cmp.mapping.confirm()
							return
						end
					end
					fallback()
				end), 'Enter'
			}
		}, { mode = 'i' })
	end,
}

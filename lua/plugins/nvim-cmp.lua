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
		local luasnip = require('luasnip')
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
		end

		opts.mapping = {
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					if #cmp.get_entries() == 1 then
						cmp.confirm({ select = true })
					else
						cmp.select_next_item()
					end
					--[[ Replace with your snippet engine (see above sections on this page)
					elseif snippy.can_expand_or_advance() then
					snippy.expand_or_advance() ]]
				elseif has_words_before() then
					cmp.complete()
					if #cmp.get_entries() == 1 then
						cmp.confirm({ select = true })
					end
				else
					fallback()
				end
			end, { "i", "s" }),
			["<CR>"] = cmp.mapping({
				i = function(fallback)
					if cmp.visible() and cmp.get_active_entry() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
					else
						fallback()
					end
				end,
				s = cmp.mapping.confirm({ select = true }),
				c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
			}),
			['<C-e>'] = cmp.mapping.abort(),
			['<Esc>'] = cmp.mapping.abort(),
		}
		cmp.setup(opts)
		-- Set up autopairs
		cmp.event:on(
		  'confirm_done',
		  require('nvim-autopairs.completion.cmp').on_confirm_done()
		)

		wk.add({
			mode = { 'i' },
			-- Note that calling each of these functions returns another function
			{ '<S-Tab>', function() cmp.mapping.select_prev_item() end, desc = 'Select Previous' },
			{ '<C-d>', function() cmp.mapping.scroll_docs(-4) end, desc = 'Scroll Down' },
			{ '<C-f>', function() cmp.mapping.scroll_docs(4) end, desc = 'Scroll Up' },
			{ '<C-e>', function() cmp.mapping.close() end, desc = 'Close' },
		})
	end,
}

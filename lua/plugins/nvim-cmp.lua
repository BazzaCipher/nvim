-- Neovim autocomplete
-- Very important to have snippet completion

-- Diagnostic column and some ms of no cursor movement to trigger CursorHold
vim.wo.signcolumn = 'yes'
vim.opt.updatetime = 300

return {
	'hrsh7th/nvim-cmp',
	dependencies = { 
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-emoji',
		'L3MON4D3/LuaSnip',
		'Saecki/crates.nvim',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'hrsh7th/cmp-cmdline',
		'windwp/nvim-autopairs',
	},
	event = { 'InsertEnter', 'CmdlineEnter' },
	opts = {
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		-- Installed sources
		sources = {
			{ name = 'nvim-lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'nvim-lua' },
			{ name = 'emoji' },
			{ name = 'luasnip' },
			{ name = 'crates' },
			{ name = 'nvim-lsp_signature-help' },
			{ name = 'cmdline' },
			{ name = 'autopairs' },
		},
	},
	config = function(plugin, opts)
	-- 	-- TODO Fix this
		local cmp = require('cmp')
		local wk = require('which-key')
		cmp.setup(opts)
		
	-- 	-- Set up autopairs TODO: check if necessary
	-- 	cmp.event:on(
	-- 	  'confirm_done',
	-- 	  cmp_autopairs.on_confirm_done()
	-- 	)
	--
	-- 	wk.register({
	-- 		-- Note that calling each of these functions returns another function
	-- 		['<Tab>'] = { cmp.mapping.select_next_item(), 'Select Next' },
	-- 		['<S-Tab>'] = { cmp.mapping.select_prev_item(), 'Select Previous' },
	-- 		['<C-d>'] = { cmp.mapping.scroll_docs(-4), 'Scroll Down' },
	-- 		['<C-f>'] = { cmp.mapping.scroll_docs(4), 'Scroll Up' },
	-- 		['<C-e>'] = { cmp.mapping.close(), 'Close' },
	-- 		-- ['<CR>'] = { cmp.mapping(
	-- 		-- 	function(fallback)
	-- 		-- 		if cmp.visible() then
	-- 		-- 			local entry = cmp.get_selected_entry()
	-- 		-- 			if entry then
	-- 		-- 				cmp.mapping.confirm()
	-- 		-- 				return
	-- 		-- 			end
	-- 		-- 		end
	-- 		-- 		fallback()
	-- 		-- 	end), 'Enter'
	-- 		-- }
	-- 		['<CR>'] = { cmp.mapping.confirm({ select = false }) }
	-- 	}, { mode = 'i' })
	-- end,
	---@param opts cmp.ConfigSchema
	-- opts = function(_, opts)
	-- 	local cmp = require('cmp')
	-- 	opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = 'emoji' } }))
	end,
}

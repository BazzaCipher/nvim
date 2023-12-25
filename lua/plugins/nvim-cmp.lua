-- Neovim autocomplete
-- Very important to have snippet completion

local cmp = require('cmp')

-- Diagnostic column and some ms of no cursor movement to trigger CursorHold
vim.wo.signcolumn = 'yes'
vim.opt.updatetime = 300

return {
	'hrsh7th/nvim-cmp',
	dependencies = { 
		'hrsh7th/cmp-emoji',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lua',
	},
	opts = {
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		mapping = {
			-- Add tab support
			['<S-Tab>'] = cmp.mapping.select_next_item(),
			-- ['<Tab>'] = cmp.mapping.complete(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			-- ['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			-- ['<Tab>'] = cmp.mapping.confirm({
			-- 	behavior = cmp.ConfirmBehavior.Insert,
			-- 	select = false,
			["<Tab>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
				if cmp.visible() then
					local entry = cmp.get_selected_entry()
			if not entry then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				cmp.confirm()
			end
				else
					fallback()
				end
			end, {"i","s","c",}),			-- }),
		},
		-- Installed sources
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'path' },
			{ name = 'buffer' },
			{ name = 'nvim_lua' },
			{ name = 'emoji' },
			{ name = 'luasnip' },
		},
	}
	---@param opts cmp.ConfigSchema
	-- opts = function(_, opts)
	-- 	local cmp = require('cmp')
	-- 	opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = 'emoji' } }))
	-- end,
}

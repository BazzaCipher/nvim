-- Lualine
return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		theme = 'nord',
		sections = {
			lualine_c = {
				{
					'filename',
					path = 1,                 -- relative in the bar
					shorting_target = 40,
					file_status = true,
					on_click = function(_, mouse_btn)
						if mouse_btn ~= 'l' then return end
						local p = vim.fn.expand('%:p')
						if p == '' then return end
						vim.notify(p, vim.log.levels.INFO, { title = 'Full path', timeout = 3000 })
					end,
				},
			},
		},
	},
	extensions = { 'fzf', 'nvim-tree' },
}

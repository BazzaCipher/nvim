-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	'lewis6991/gitsigns.nvim',
	opts = {
		-- See `:help gitsigns.txt`
		sign_priority = 50,
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		on_attach = function(bufnr)
			local gs = require('gitsigns')
			local wk = require('which-key')

			wk.add({
				-- Navigation
				{ ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, desc = 'Next Hunk', expr = true, buffer = bufnr },
				{ '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, desc = 'Prev Hunk', expr = true, buffer = bufnr },

				-- Hunk actions
				{ '<leader>h', group = 'hunk' },
				{ '<leader>hs', gs.stage_hunk, desc = 'Stage Hunk', buffer = bufnr },
				{ '<leader>hs', function()
					gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
				end, desc = 'Stage Hunk', mode = 'v', buffer = bufnr },
				{ '<leader>hr', gs.reset_hunk, desc = 'Reset Hunk', buffer = bufnr },
				{ '<leader>hr', function()
					gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
				end, desc = 'Reset Hunk', mode = 'v', buffer = bufnr },
				{ '<leader>hS', gs.stage_buffer, desc = 'Stage Buffer', buffer = bufnr },
				{ '<leader>hu', gs.undo_stage_hunk, desc = 'Undo Stage Hunk', buffer = bufnr },
				{ '<leader>hR', gs.reset_buffer, desc = 'Reset Buffer', buffer = bufnr },
				{ '<leader>hp', gs.preview_hunk, desc = 'Preview Hunk', buffer = bufnr },
				{ '<leader>hb', function() gs.blame_line{full=true} end, desc = 'Blame Line', buffer = bufnr },
				{ '<leader>hB', gs.toggle_current_line_blame, desc = 'Toggle Line Blame', buffer = bufnr },
				{ '<leader>hd', gs.diffthis, desc = 'Diff', buffer = bufnr },
				{ '<leader>hD', function() gs.diffthis('~') end, desc = 'Diff all', buffer = bufnr },
				{ '<leader>ht', gs.toggle_deleted, desc = 'Toggle Deleted', buffer = bufnr },
			})
		end,
	},
}

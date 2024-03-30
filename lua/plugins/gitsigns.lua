-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	'lewis6991/gitsigns.nvim',
	opts = {
		-- See `:help gitsigns.txt`
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

			-- Default navigation (from vimdiff defaults)
			wk.register({
				[']c'] = { function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, 'Next Hunk', expr = true},
				['[c'] = { function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, 'Prev Hunk', expr = true}
			}, { buffer = bufnr })

			-- Other hunk actions
			wk.register({
				name = "+hunk",
				s = { gs.stage_hunk, '[S]tage Hunk'},
				r = { gs.reset_hunk, '[R]eset Hunk'},
				-- Don't know what the correct way of specifying mode v is
				s = { function()
					gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')}
				end, '[S]tage Hunk', mode ='v' },
				r = { function()
					gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')}
				end, '[R]eset Hunk', mode ='v' },
				S = { gs.stage_buffer, '[S]tage Buffer' },
				u = { gs.undo_stage_hunk, '[U]ndo Stage Hunk'},
				R = { gs.reset_buffer, '[R]eset Buffer' },
				p = { gs.preview_hunk, '[P]review Hunk' },
				b = { function() gs.blame_line{full=true} end, '[B]lame Line' },
				B = { gs.toggle_current_line_blame, '[T]oggle Line Blame' },
				d = { gs.diffthis, '[D]iff' },
				D = { function() gs.diffthis('~') end, '[D]iff all' },
				t = { gs.toggle_deleted, '[T]oggle Deleted' }
			}, { prefix = '<leader>h' })
		end,
	},
}

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
			wk.add({
				{ ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, desc = 'Next Hunk', expr = true},
				{ '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, desc = 'Prev Hunk', expr = true}
			}, { buffer = bufnr })

			-- Other hunk actions
			wk.add({
				{ "<leader>h", group = "hunk" },
				{ "<leader>hs", function()
					gs.stage_hunk(vim.fn.line('.'), vim.fn.line('v')) end,
					desc = "[S]tage Hunk", mode = "v" },
				{ "<leader>hr", function()
					gs.reset_hunk(vim.fn.line('.'), vim.fn.line('v')) end,
					desc = "[R]eset Hunk", mode = "v" },
				{ "<leader>hS", gs.stage_buffer, desc = "[S]tage Buffer" },
				{ "<leader>hu", gs.undo_stage_hunk, desc = "[U]ndo Stage Hunk" },
				{ "<leader>hR", gs.reset_buffer, desc = "[R]eset Buffer" },
				{ "<leader>hp", gs.preview_hunk, desc = "[P]review Hunk" },
				{ "<leader>hb", function()
					gs.blame_line{ full = true } end,
					desc = "[B]lame Line" },
				{ "<leader>hB", gs.toggle_current_line_blame, desc = "[T]oggle Line Blame" },
				{ "<leader>hd", gs.difftthis, desc = "[D]iff" },
				{ "<leader>hD", function()
					gs.diffthis('~') end,
					desc = "[D]iff all" },
				{ "<leader>ht", gs.toggle_deleted, desc = "[T]oggle Deleted" },
				})
		end,
	},
}

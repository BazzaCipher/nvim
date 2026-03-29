return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		'mfussenegger/nvim-dap',
		'nvim-neotest/nvim-nio',
	},
	on_attach = function(bufnr)
		-- DAP remappings
		local rn = function(desc)
			if desc then
				return "DAP: " .. desc
			end
		end

		require('which-key').add({
			{ '<leader>d', group = 'debugger', buffer = bufnr },
			{ '<leader>ds', function()
				dap.continue()
				require('dapui').toggle({})
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false)
			end, desc = rn('Start debugger'), buffer = bufnr },
			{ '<leader>de', function()
				dap.clear_breakpoints()
				require('dapui').toggle({})
				dap.terminate()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
			end, desc = rn('End debugger'), buffer = bufnr },
			{ '<leader>dc', dap.continue, desc = rn('Continue'), buffer = bufnr },
			{ '<leader>db', dap.toggle_breakpoint, desc = rn('Toggle Breakpoint'), buffer = bufnr },
			{ '<leader>dn', dap.step_over, desc = rn('Step Over'), buffer = bufnr },
			{ '<leader>di', dap.step_into, desc = rn('Step Into'), buffer = bufnr },
			{ '<leader>do', dap.step_out, desc = rn('Step Out'), buffer = bufnr },
			{ '<leader>dC', function()
				dap.clear_breakpoints()
			end, desc = rn('Clear Breakpoints'), buffer = bufnr },
		})

	end
}

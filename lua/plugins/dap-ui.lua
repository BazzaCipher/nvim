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
			{ '<leader>d', group = "debugger" },
			{ '<leader>ds', function()
				dap.continue()
				require('dapui').toggle({})
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false) -- Even space buffers end
			end, desc = rn('[S]tart debugger') },
			{ '<leader>de', function()
				dap.clear_breakpoints()
				require('dapui').toggle({})
				dap.terminate()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
				-- require("notify")("Debugger session ended", "warn")
			end, desc = rn('[E]nd debugger') },
			{ '<leader>dc', dap.continue, rn('[C]ontinue') },
			{ '<leader>db', dap.toggle_breakpoint, rn('Toggle [B]reakpoint') },
			{ '<leader>dn', dap.step_over, rn('Step Over') },
			{ '<leader>di', dap.step_into, rn('Step [I]nto') },
			{ '<leader>do', dap.step_out, rn('Step [O]ut') },
			{ '<leader>dC', function()
				dap.clear_breakpoints()
				-- require('notify')('Breakpoints cleared', 'warn')
			end, rn('[C]lear Breakpoints')},
			{ buffer = bufnr }
		})
	end
}

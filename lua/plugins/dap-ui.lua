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

		require('which-key').register({ ["<leader>d"] = {
			name = "+debugger",
			s = {function()
				dap.continue()
				require('dapui').toggle({})
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', false, true, true), 'n', false) -- Even space buffers end
			end, rn('[S]tart debugger')},
			e = { function()
				dap.clear_breakpoints()
				require('dapui').toggle({})
				dap.terminate()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
				-- require("notify")("Debugger session ended", "warn")
			end, rn('[E]nd debugger')},
			c = { dap.continue, rn('[C]ontinue') },
			b = { dap.toggle_breakpoint, rn('Toggle [B]reakpoint') },
			n = { dap.step_over, rn('Step Over') },
			i = { dap.step_into, rn('Step [I]nto') },
			o = { dap.step_out, rn('Step [O]ut') },
			C = { function()
				dap.clear_breakpoints()
				-- require('notify')('Breakpoints cleared', 'warn')
			end , rn('[C]lear Breakpoints')}
		}}, { buffer = bufnr })

	end
}

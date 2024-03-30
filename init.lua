-- Keymappings Locations:
-- lua\plugins\nvim-cmp.lua - Autocomplete mappings
-- lua\plugins\telescope.lua - Telescope mappings
--
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('options')
require('keymaps')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ import = 'plugins' },
}, {})

-- Use Nord theme
vim.cmd.colorscheme 'nord'

-- Telescope prefix naming
local wk = require('which-key')
wk.register({['<leader>f'] = { name = '+file' } })

-- Leap motions
require('leap').add_default_mappings()

-- Set up status line
require('lualine').setup{ options = { theme = 'nord' } }

-- Configure LSP and Default Keymaps
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

-- Configure LSP
-- require'lspconfig'.rust_analyzer.setup{
-- 	server = {
-- 		settings = {
-- 			['rust-analyzer'] = {
-- 				diagnostics = {
-- 					enable = false
-- 				}
-- 			}
-- 		},
-- 		on_attach = on_attach,
-- 	}
-- }

-- Commenting
require('Comment').setup()

require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('dapui').setup({
	icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		{
			elements = {
				"scopes",
			},
			size = 0.3,
			position = "right"
			},
			{
				elements = {
					"repl",
					"breakpoints"
				},
				size = 0.3,
				position = "bottom",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "single",
			mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
	max_type_length = nil,
	},
})

-- Must occur after mason is set up
require("mason-nvim-dap").setup({
	ensure_installed = { "codelldb" },
	automatic_setup = true
})

local dap = require('dap')
local cwd = vim.fn.getcwd()
local exefile = cwd .. '\\target\\debug\\' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. '.exe'
dap.configurations.rust = {
  {
    name = "Launch file",
    type = "rt_lldb",
    request = "launch",
    program = function()
		vim.fn.jobstart('cargo build')
		return exefile
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
	showDisassembly = 'never',
  },
}

vim.fn.sign_define('DapBreakpoint', { text = '🐞' }) -- Looks pretty

-- DAP remappings
local rn = function(desc)
	if desc then
		return "DAP: " .. desc 
	end
end
wk.register({ ["<leader>d"] = {
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

local codelldb_root = require("mason-registry").get_package("codelldb"):get_install_path() .. "\\extension\\"
local codelldb_path = codelldb_root .. "adapter\\codelldb.exe"
local liblldb_path = codelldb_root .. "lldb\\lib\\liblldb.lib"

local adap = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
adap.executable.detached = false

local rusttoolsopts = {
	tools = {
		autoSetHints = true,
	},
	dap = {
		adapters = adap
	},
	server = {
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy"
				}
			}
		}
	}
}

require('rust-tools').setup(rusttoolsopts)

-- Install xclip if we haven't got it
local xclipinstall = function()
	if vim.fn.has('unix') and vim.fn.system('dpkg-query -s xclip 2>/dev/null | grep -c "ok installed"') == 0 then
		print("Please install 'xclip' for system clipboard functionality")
	end
end

xclipinstall()


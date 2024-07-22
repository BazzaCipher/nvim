vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Import keybinds and options for default vim, i.e. not plugin-dependent
require('options')
require('keymaps')

-- Guarantees install of lazy.nvim
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

-- Imports all the packages in the lua/plugins folder
require('lazy').setup({
	{ import = 'plugins' },
}, {})

----- Breakdown of all the plugins -----
-- nord                 - Colorscheme
-- which-key            - Key mapping manager
-- telescope            - File search
-- telescope-fzf-native - Fuzzy matching for telescope
-- gitsigns             - Interact with git
-- leap                 - Better navigation
-- lualine              - Status line, needs gitsigns
--
-- nvim-lspconfig       - Set up the LSP
-- nvim-cmp             
-- mason
-- mason-nvim-dap
-- rust-tools
-- nvim-dap
-- luasnip
-- cmp-emoji
-- comment
-- crates
-- dap-ui
-- plenary

----- Breakdown of all common shortcuts
-- <C-f>, <C-c> for better text hopping
-- <C-n>, <C-s> for terminal and split
-- [d, ]d for going to diagnostic messages
-- <leader>e + q for diagnostic messages and list
-- <leader>[ + ] for system clipboard

-- Leap motions
-- s for navigation
-- S for cross-window navigation

-- Configure LSP and Default Keymaps
-- -- Configure LSP
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

-- Must occur after mason is set up
require("mason-nvim-dap").setup({
	ensure_installed = {
		"codelldb",
		-- Append any necessary here
	},
	automatic_setup = true
})

-- Set up DAP
vim.fn.sign_define('DapBreakpoint', { text = '🐞' }) -- Looks pretty

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

require('dapui')
-- require('dapui').setup({
-- 	icons = { expanded = "▾", collapsed = "▸" },
-- 		mappings = {
-- 			open = "o",
-- 			remove = "d",
-- 			edit = "e",
-- 			repl = "r",
-- 			toggle = "t",
-- 		},
-- 	expand_lines = vim.fn.has("nvim-0.7"),
-- 	layouts = {
-- 		{
-- 			elements = {
-- 				"scopes",
-- 			},
-- 			size = 0.3,
-- 			position = "right"
-- 			},
-- 			{
-- 				elements = {
-- 					"repl",
-- 					"breakpoints"
-- 				},
-- 				size = 0.3,
-- 				position = "bottom",
-- 			},
-- 		},
-- 		floating = {
-- 			max_height = nil,
-- 			max_width = nil,
-- 			border = "single",
-- 			mappings = {
-- 			close = { "q", "<Esc>" },
-- 		},
-- 	},
-- 	windows = { indent = 1 },
-- 	render = {
-- 	max_type_length = nil,
-- 	},
-- })

----- Start lspconfig because it doesn't automagically
-- require('lspconfig').setup()

local codelldb_root = require("mason-registry").get_package("codelldb"):get_install_path() .. "\\extension\\"
local codelldb_path = codelldb_root .. "adapter\\codelldb.exe"
local liblldb_path = codelldb_root .. "lldb\\lib\\liblldb.lib"

local adap = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
adap.executable.detached = false

-- local rusttoolsopts = {
-- 	tools = {
-- 		autoSetHints = true,
-- 	},
-- 	dap = {
-- 		adapters = adap
-- 	},
-- 	server = {
-- 		-- on_attach = on_attach,
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				checkOnSave = {
-- 					command = "clippy"
-- 				}
-- 			}
-- 		}
-- 	}
-- }
--
-- require('rust-tools').setup(rusttoolsopts)
--

---- Debugging the lsp
-- vim.lsp.set_log_level('debug')
-- vim.cmd('edit ' .. vim.lsp.get_log_path())


-- plugins
vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- lsp
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	{ src = "https://github.com/saghen/blink.cmp" },
	"https://github.com/saghen/blink.lib",
	"https://github.com/stevearc/conform.nvim",
	-- colo
	-- zenbones dependency
	"https://github.com/rktjmp/lush.nvim",
	{
		src = "https://github.com/zenbones-theme/zenbones.nvim",
		name = "zenbones",
	},
	--"https://github.comavarasu/onedark.nvim",
	"https://github.com/Mofiqul/vscode.nvim",
})

--require("zenbones").setup({})
vim.cmd.colorscheme("neobones")
--require("onedark").setup({
--	style = "warmer",
--})
--vim.cmd.colorscheme("onedark")

require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end)
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end)
vim.keymap.set("n", "<leader>gs", function()
	require("fzf-lua").git_status()
end)
vim.keymap.set("n", "<leader>gl", function()
	require("fzf-lua").git_commits()
end)
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end)

require("mini.pairs").setup({})
require("mini.indentscope").setup({})
require("mini.tabline").setup({})

-- treesitter
local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"rust",
		"c",
		"cpp",
		"go",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"bash",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

-- lsp

require("lsp")

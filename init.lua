--comment
vim.opt.termguicolors = true
vim.cmd.colorscheme("retrobox")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- tabs & indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.grepprg = "rg --vimgrep"

--search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.showmatch = true

-- stop newline from auto comment
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "*" },
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
	desc = "don't continue comments when entering new line",
})

-- use system clipboard
vim.opt.clipboard:append("unnamedplus")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "prev buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "delete buffer" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection down" })

require("plugins")

vim.cmd([[set mouse=a]])
vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
-- Configure tab
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
-- end configure tabs
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')

-- install packages
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-mini/mini.starter" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.cmd("colorscheme vague")

require("nvim-tree").setup()
map('n', '<leader>e', ":NvimTreeToggle<CR>")

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Lookup this for language server names:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
servers = {"gopls", "rust_analyzer", "clangd"}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.lsp.enable(servers)
-- quality of life feature so nothing is selected by default when auto completing
vim.cmd [[set completeopt+=menuone,noselect,popup]]
map('i', '<C-e>', function() vim.lsp.completion.get() end)

map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation'})
map('n', 'gr', vim.lsp.buf.references, bufopts, { desc = 'Show references' })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

require('mini.starter').setup({
  header = [[Welcome back]],

  footer = nil,
})

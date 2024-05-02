-- nvim-sops
vim.keymap.set("n", "<leader>ef", vim.cmd.SopsEncrypt, { desc = "[E]ncrypt [F]ile" })
vim.keymap.set("n", "<leader>df", vim.cmd.SopsDecrypt, { desc = "[D]ecrypt [F]ile" })

-- fzf
vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", "<cmd>lua require('fzf-lua').quickfix()<CR>", { silent = true })
vim.keymap.set("n", "<leader>gg", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

-- telescope
vim.keymap.set("n", "<leader>bf", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", "<cmd>lua require('telescope.builtin').builtin()<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { silent = true })
vim.keymap.set("n", "<leader>m", "<cmd>lua require('telescope').extensions.ghq.list()<CR>", { silent = true })

-- spectre
vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').toggle()<CR>", { silent = true })
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { silent = true })
vim.keymap.set(
	"n",
	"<leader>sp",
	"<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
	{ silent = true }
)
vim.keymap.set("n", "<leader>sr", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("v", "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<CR>", { silent = true })

-- neogit
vim.keymap.set("n", "<leader>gs", require("neogit").open, { silent = true })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { silent = true })

-- nvim-tree
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { silent = true })

-- LSP
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<space>h", "<cmd>lua vim.lsp.inlay_hint.enable(0, true)<CR>", { silent = true })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "cf", vim.lsp.buf.format, opts)
	end,
})

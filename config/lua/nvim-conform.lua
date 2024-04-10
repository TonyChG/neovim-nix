require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		nix = { "alejandra" },
		yaml = { "yamlfmt" },
	},
})
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format Files" })

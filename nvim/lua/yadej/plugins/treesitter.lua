return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	enabled = true,

	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"vim",
			"vimdoc",
			"c",
			"cpp",
			"rust",
			"lua",
			"ruby",
			"html",
			"bash",
			"markdown",
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- Enable indentation
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
				if lang then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}


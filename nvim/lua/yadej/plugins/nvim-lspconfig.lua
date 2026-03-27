return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	enabled = true,
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Disable inline error messages
		vim.diagnostic.config({
			virtual_text = false,
			float = {
				border = "single",
			},
		})

		-- Add border to floating window
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })
		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, { border = "single", silent = true })

		-- Make float window transparent start

		local set_hl_for_floating_window = function()
			vim.api.nvim_set_hl(0, "NormalFloat", {
				link = "Normal",
			})
			vim.api.nvim_set_hl(0, "FloatBorder", {
				bg = "none",
			})
		end

		set_hl_for_floating_window()

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			desc = "Avoid overwritten by loading color schemes later",
			callback = set_hl_for_floating_window,
		})

		-- Make float window transparent end

		local on_attach = function(client, bufnr)
			vim.keymap.set(
				"n",
				"K",
				vim.lsp.buf.hover,
				{ buffer = bufnr, desc = "Show documentation for what is under cursor" }
			)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })
			vim.keymap.set(
				{ "n", "v" },
				"gf",
				vim.lsp.buf.code_action,
				{ buffer = bufnr, desc = "See available code actions" }
			)
			vim.keymap.set(
				"n",
				"<leader>d",
				vim.diagnostic.open_float,
				{ buffer = bufnr, desc = "Show diagnostics for line" }
			)
			-- vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", {buffer = bufnr, desc = 'Show definition, references'})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local signs = { Error = "✖", Warn = "", Hint = "󰠠", Info = "" }
		for type, icon in pairs(signs) do
			vim.fn.setloclist(0, {}, " ", {
				text = icon,
				texthl = "DiagnosticSign" .. type,
				numhl = "DiagnosticSign" .. type,
			})
		end

		-- configure cpp server
		vim.lsp.enable("clangd")
		-- configure html server
		vim.lsp.enable("html")
		vim.lsp.enable("pyright")
		vim.lsp.enable("mypy")

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library'
							-- '${3rd}/busted/library'
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = {
						--   vim.api.nvim_get_runtime_file('', true),
						-- }
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})

		-- configure css server
		vim.lsp.enable("cssls")
	end,
}

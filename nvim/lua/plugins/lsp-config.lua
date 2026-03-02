-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gb", "<C-o>", opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local servers = {
				"lua_ls", -- Lua
				"vimls", -- VimL
				"pylsp", -- Python
				"clangd", -- C/C++
				-- 'pasls',      -- Pascal
				"yamlls", -- YAML
				"bashls", -- Bash & Zsh
				"gopls", -- Go
				"ts_ls", -- JavaScript / TypeScript
			}
			require("mason-lspconfig").setup({
				ensure_installed = servers,
                auto_install = true,
				automatic_installation = true,
			})
		end,
	},
    {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                'stylua',
                'black',
                'autopep8',
                'flake8',
                'prettier',
            },
            auto_update = true,
            run_on_start = true,
        })
    end
}
}

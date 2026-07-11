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
            local opts = { noremap = true, silent = true }
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
            local server_requirements = {
                lua_ls = "lua",
                vimls = "vim",
                -- pylsp = "python3",
                pyright = "python3",
                clangd = "clang",
                yamlls = "npm",
                bashls = "npm",
                gopls = "go",
                ts_ls = "npm",
            }

            local servers_to_install = {}
            for server, binary in pairs(server_requirements) do
                if vim.fn.executable(binary) == 1 then
                    table.insert(servers_to_install, server)
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = servers_to_install,
                auto_install = true,
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local tool_requirements = {
                stylua = "lua",
                black = "python3",
                autopep8 = "python3",
                flake8 = "python3",
                prettier = "npm",
            }

            local tools_to_install = {}
            for tool, binary in pairs(tool_requirements) do
                if vim.fn.executable(binary) == 1 then
                    table.insert(tools_to_install, tool)
                end
            end

            require("mason-tool-installer").setup({
                ensure_installed = tools_to_install,
                auto_update = true,
                run_on_start = true,
            })
        end
    }
}

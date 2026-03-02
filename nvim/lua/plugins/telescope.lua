return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
--        keys = {
--            { "<leader>ff", "<cmd>telescope find_files<cr>", desc = "find files" },
--            { "<leader>fg", "<cmd>telescope live_grep<cr>", desc = "live grep" },
--            { "<leader>fb", "<cmd>telescope buffers<cr>", desc = "buffers" },
--            { "<leader>fh", "<cmd>telescope help_tags<cr>", desc = "help tags" },
--          },

            local telescope = require('telescope')
            telescope.setup({
                defaults = {
                    mappings = {
                        i = {["<c-h>"] = "which_key"}
                    }
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    }
                },
            })
            telescope.load_extension('ui-select')
        end
    },
}


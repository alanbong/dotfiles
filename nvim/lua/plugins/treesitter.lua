return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end

        configs.setup({
            ensure_installed = {
                'lua', 'vim', 'vimdoc', 'query',
                'javascript', 'python', 'bash',
                'c', 'pascal', 'asm', 'nasm', 'java',
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}

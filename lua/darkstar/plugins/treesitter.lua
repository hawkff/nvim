return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- Enable highlighting for all filetypes with available parsers
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    }
}



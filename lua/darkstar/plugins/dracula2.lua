return {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local colors = require("dracula").colors()
        local searchHighlight = { bg = "#3e68d7", fg = colors.fg }

        -- Initialize with basic settings
        require("dracula").setup({
            colors = {
                bright_red = colors.comment,
            },
            transparent_bg = false,
            overrides = {
                CursorLine = { bg = colors.selection },
                Search = searchHighlight,
                IncSearch = searchHighlight,
            },
        })

        -- Function to apply transparent background
        function MakeItDracula(color)
            color = color or "dracula"
            vim.cmd.colorscheme(color)
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end

        -- Function to apply full Dracula theme with all overrides
        function SetDraculaFull()
            vim.cmd.colorscheme("dracula")

            -- Apply additional overrides for full Dracula theme
            local searchHighlight = { bg = "#3e68d7", fg = colors.fg }
            vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#FF007C", bold = true })
            vim.api.nvim_set_hl(0, "FlashMatch", searchHighlight)
            vim.api.nvim_set_hl(0, "FlashCurrent", searchHighlight)
        end

        -- Apply MakeItDracula by default at startup
        MakeItDracula()

        -- Set keymaps for both methods
        vim.api.nvim_set_keymap('n', '<leader>pcp', ':lua MakeItDracula()<CR>',
            { noremap = true, desc = "MakeItDracula (transparent bg)" })

        vim.api.nvim_set_keymap('n', '<leader>pcd', ':lua SetDraculaFull()<CR>',
            { noremap = true, desc = "Set Full Dracula Theme" })
    end
}

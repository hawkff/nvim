return {
    "Mofiqul/dracula.nvim",
    lazy = true,
    priority = 1000,
    config = function()
        local colors = require("dracula").colors()
        local searchHighlight = { bg = "#3e68d7", fg = colors.fg }

        require("dracula").setup({
            transparent_bg = false,
            overrides = {
                CursorLine = { bg = colors.selection },
                Search = searchHighlight,
                IncSearch = searchHighlight,
            },
        })

        function MakeItDracula(color)
            color = color or "dracula"
            vim.cmd.colorscheme(color)
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end

        MakeItDracula()

        vim.api.nvim_set_keymap('n', '<leader>pcp', ':lua MakeItDracula()<CR> ',
            { noremap = true, desc = "MakeItDracula" })
    end
}

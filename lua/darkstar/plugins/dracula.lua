return {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local colors = require("dracula").colors()
        local searchHighlight = { bg = "#3e68d7", fg = colors.fg }

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

        -- Apply the colorscheme with a transparent background
        local function make_it_dracula(color)
            color = color or "dracula"
            vim.cmd.colorscheme(color)
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end

        -- Apply the full theme, opaque background included
        local function set_dracula_full()
            vim.cmd.colorscheme("dracula")
        end

        make_it_dracula()

        vim.keymap.set("n", "<leader>pcp", make_it_dracula, { desc = "Dracula (transparent bg)" })
        vim.keymap.set("n", "<leader>pcd", set_dracula_full, { desc = "Dracula (full theme)" })
    end
}

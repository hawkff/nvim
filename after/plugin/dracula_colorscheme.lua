local colors = require("dracula").colors()                 -- get the colors from the colorscheme
local searchHighlight = { bg = "#3e68d7", fg = colors.fg } -- set the search highlight color
----------------------------------------------------------
require("dracula").setup({
    colors = {
        bright_red = colors.comment,
    },
    transparent_bg = false,
    overrides = {
        CursorLine = { bg = colors.selection },
        FlashLabel = { bg = "#FF007C", bold = true },
        Search = searchHighlight,
        IncSearch = searchHighlight,
        FlashMatch = searchHighlight,
        FlashCurrent = searchHighlight,
    },
}) -- set the colorscheme and override some settings

vim.api.nvim_set_keymap('n', '<leader>pcd', ':color dracula<CR> ', { noremap = true, desc = "Set Dracula Color" })

---------------------------------------------------------------------------------
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     pattern = "*.swift",
--     callback = function()
--         -- vim.cmd("source ~/.config/nvim/after/plugin/swift-colorscheme.lua")
--         vim.cmd("colorscheme dracula")
--     end,
-- }) -- when entering a buffer(swift filetype), set the colorscheme to custom

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "netrw",
--     callback = function()
--         ColorMyPencils()
--     end,
-- })

-- vim.api.nvim_create_autocmd("BufWinLeave", {
--     pattern = "*.*",
--     callback = function()
--         ColorMyPencils()
--     end,
-- }) -- when leaving a buffer, reset the colorscheme to custom

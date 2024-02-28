require("hawky.lazy")
require("hawky.remap")
require("hawky.set")

----------------------------------------------
local augroup = vim.api.nvim_create_augroup     -- create a function that creates an autogroup, :h augroup
local hawkyGroup = augroup('hawky', {})         -- create an autogroup named hawky

local autocmd = vim.api.nvim_create_autocmd     -- create a function that creates an autocmd, :h autocmd
local yank_group = augroup('HighlightYank', {}) -- create an autogroup named HighlightYank
----------------------------------------------
-- reload a module
function R(name)
    require("plenary.reload").reload_module(name)
end

----------------------------------------------

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
}) -- highlight yank
----------------------------------------------

autocmd({ "BufWritePre" }, {
    group = hawkyGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
}) -- remove trailing whitespace
----------------------------------------------
-- netrw settings
-- Line numbers etc in Netrw
vim.cmd([[let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro']])

vim.g.netrw_browse_split = 0 -- open netrw in the same window
-- vim.g.netrw_banner = 0 -- disable banner
-- vim.g.netrw_winsize = 25     -- set netrw window size
----------------------------------------------

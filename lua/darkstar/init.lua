-- Initialize the minimal configuration
require("darkstar.set")     -- Core Vim settings
require("darkstar.lazy")    -- Plugin manager setup
require("darkstar.remap")   -- Core remaps (without plugin dependencies)

----------------------------------------------
local augroup = vim.api.nvim_create_augroup     -- Create a function that creates an autogroup
local hawkyGroup = augroup('darkstar', {})    -- Create an autogroup named darkstar

local autocmd = vim.api.nvim_create_autocmd     -- Create a function that creates an autocmd
local yank_group = augroup('HighlightYank', {}) -- Create an autogroup named HighlightYank
----------------------------------------------

-- Highlight on yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove trailing whitespace on save
autocmd({ "BufWritePre" }, {
    group = hawkyGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Netrw settings
vim.g.netrw_keepdir = 1
vim.g.netrw_silent = 1
--vim.cmd([[let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro']])
vim.cmd([[let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro']])

vim.g.netrw_browse_split = 0

-- Prevent shared data (shada) file corruption
vim.opt.shada = "'1000,f1,<1000"

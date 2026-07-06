-- Core Vim settings ()
vim.opt.mouse = ""                                      -- Disable mouse support
vim.opt.guicursor = ""                                  -- Set the cursor shape in GUI versions of Neovim

vim.opt.nu = true                                       -- Display line numbers
vim.opt.relativenumber = true                           -- Display line numbers relative to the cursor

vim.opt.tabstop = 4                                     -- Set the number of spaces per tab
vim.opt.softtabstop = 4                                 -- Number of spaces to use for an automatic indent
vim.opt.shiftwidth = 4                                  -- Width of a tab, in spaces
vim.opt.expandtab = true                                -- Convert tabs to spaces

vim.opt.smartindent = true                              -- Automatically indent based on file type

vim.opt.wrap = false                                    -- Disable line wrapping

vim.opt.swapfile = false                                -- Disable swap file creation
vim.opt.backup = false                                  -- Disable backup file creation
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Set directory for undo files
vim.opt.undofile = true                                 -- Enable persistent undo

vim.opt.hlsearch = false                                -- Disable highlighting of search matches
vim.opt.incsearch = true                                -- Incrementally highlight as you type your search pattern

vim.opt.scrolloff = 8                                   -- Keep a minimum of 8 lines above/below the cursor when scrolling
vim.opt.signcolumn = "yes"                              -- Always display the sign column
vim.opt.isfname:append("@-@")                           -- Append specific characters to the 'isfname' option

vim.opt.updatetime = 50                                 -- Time (ms) of inactivity before CursorHold fires

vim.opt.colorcolumn = ""                                -- Disable color column

vim.api.nvim_create_autocmd("BufEnter", {               -- Disable continuation of comments on 'o'/'O'
    group = vim.api.nvim_create_augroup("darkstar-formatoptions", {}),
    callback = function()
        vim.opt_local.formatoptions:remove("o")
    end,
})

vim.opt.spell = true                                    -- Turn on grammar check

vim.o.pumblend = 15                                     -- Transparency for the popup menu

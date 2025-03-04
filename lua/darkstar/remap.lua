-- Core remaps without plugin dependencies
vim.g.mapleader = " " -- Set leader key to space

---------------------------------------------------------------------------
-- Project explorer section
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open File Explorer(Ex)" })
vim.keymap.set("n", "<leader>ps", vim.cmd.Vex, { desc = "Vertical Split & File Explorer(Vex)" })
vim.keymap.set("n", "<leader>ph", vim.cmd.Hex, { desc = "Horizontal Split & File Explorer(Hex)" })
---------------------------------------------------------------------------

-- Movement and editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & center screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & center screen" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search match & center screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search match & center screen" })

-- Clipboard operations
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selected text" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Disable potentially problematic keys
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next item in location list" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous item in location list" })

-- Search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" })

-- File permissions
vim.keymap.set("n", "<leader>px", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- Edit config files (adapt paths for your lite config)
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/darkstar/lazy.lua<CR>", { desc = "Edit lazy.lua file" })
vim.keymap.set("n", "<leader>vps", "<cmd>e ~/.config/nvim/lua/darkstar/plugins/<CR>", { desc = "Plugins config folder" })

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source current file" })

-- C++ compilation
vim.cmd([[
  function! CompileWithClang()
      let l:filename = expand('%:t')
      let l:basename = expand('%:r:t')
      execute '!' . 'clang++ --std=c++17 ' . l:filename . ' -o ' . l:basename
  endfunction
]])

vim.api.nvim_set_keymap('n', '<leader>cl', ':call CompileWithClang()<CR>', {
    noremap = true,
    silent = true,
    desc = "Compile with clang++ & c++17 "
})

-- Basic file operations
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = "Save current buffer" })
vim.api.nvim_set_keymap('n', '<leader>wq', ':wq<CR>',
    { noremap = true, silent = true, desc = "Save current buffer and quit" })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = "Quit current buffer" })

-- Delete character from file
vim.api.nvim_create_user_command(
    'DeleteChar',
    function(opts)
        local char = opts.args
        if char ~= "" then
            local escaped_char = vim.fn.escape(char, '\\')
            vim.cmd('%s/' .. escaped_char .. '//g')
        end
    end,
    { nargs = 1 }
)

-- Delete character from file (remap)
vim.api.nvim_set_keymap('n', '<leader>S', ':DeleteChar ', { noremap = true, desc = "Delete character from file" })

local builtin = require('telescope.builtin') -- builtin functions initialized here for easy access later

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Scope Find and Open files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search text in project files" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List and Switch between active files" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search Neovim help documentation" })

vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep >") })
end, { desc = "Search for a specific string in project" })

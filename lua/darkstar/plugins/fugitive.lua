return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
        -- Basic mappings
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
        vim.keymap.set("n", "<leader>gl", ":Git log --oneline<CR>", { desc = "Git Log" })
        vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff" })
        vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git Commit" })
        vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git Push" })
        vim.keymap.set("n", "<leader>gP", ":Git pull --rebase<CR>", { desc = "Git Pull with Rebase" })
    end
}

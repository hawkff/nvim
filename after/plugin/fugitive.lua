-- Map <leader>gs to the Git command (likely opens a Git status window)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

-- Create an autocmd group named "Fugitive"
local Fugitive = vim.api.nvim_create_augroup("Fugitive", {})

-- Alias for the nvim_create_autocmd function for brevity
local autocmd = vim.api.nvim_create_autocmd

-- Define an autocmd for when a buffer window is entered
autocmd("BufWinEnter", {
    group = Fugitive,
    pattern = "*",
    callback = function()
        -- Only set the following key mappings if the current buffer's filetype is 'fugitive'
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        -- Map <leader>p to push the current branch to its remote
        vim.keymap.set("n", "<leader>gp", function()
            vim.cmd.Git('push')
        end, opts, { desc = "Git Push" })

        -- Map <leader>P to pull from the remote and rebase the current branch
        vim.keymap.set("n", "<leader>gP", function()
            vim.cmd.Git({ 'pull --rebase' })
        end, opts, { desc = "Git Pull --rebase" })

        -- Map <leader>t to begin the command to push to a specific branch on the origin remote
        vim.keymap.set("n", "<leader>gt", ":Git push -u origin ",
            opts,
            { desc = "Git Push -u origin" })
    end,
})

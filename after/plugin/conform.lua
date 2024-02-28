-- conform.lua

require("conform").setup({
    formatters_by_ft = {
        swift = { "swiftformat" } -- Use swiftformat for Swift files, swiftformat must be installed
    },
    -- format_on_save = {
    --     timeout_ms = 500,
    --     lsp_fallback = true,
    -- }
}) -- Set up conform

-- Set up manual formatting for the whole file and for a selected range
vim.api.nvim_create_autocmd("FileType", {
    pattern = "swift",
    callback = function()
        -- Format the entire file
        vim.keymap.set("n", "<leader>fp", function()
            require("conform").format()
        end, { buffer = true, desc = "Format the entire Swift file" })

        -- Format a selected range in visual mode
        vim.keymap.set("x", "<leader>fp", function()
            local start_line = vim.fn.line("'<")
            local end_line = vim.fn.line("'>")
            require("conform").format({
                range = { start = { start_line, 0 }, ["end"] = { end_line, 0 } }
            })
        end, { buffer = true, desc = "Format the selected range in visual mode" })
    end,
}) -- Set up manual formatting for the whole file and for a selected range with swiftformat for Swift files

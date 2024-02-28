local ufo = require("ufo")

vim.o.foldcolumn = '0'  -- This sets the fold column to be 0 characters wide
vim.o.foldlevel = 99    -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- Enable folding

ufo.setup({
    provider_selector = function(bufnr, filetype, buftype) -- Select provider
        return { 'treesitter', 'indent' }                  -- Use treesitter and indent provider
    end,

    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate) -- Truncate virt text
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum) -- Fold icon
        local sufWidth = vim.fn.strdisplaywidth(suffix) -- Fold icon width
        local targetWidth = width - sufWidth -- Target width
        local curWidth = 0 -- Current width

        for _, chunk in ipairs(virtText) do -- Truncate virt text to target width and add fold icon
            local chunkText = chunk[1] -- Chunk text to be truncated
            local chunkWidth = vim.fn.strdisplaywidth(chunkText) -- Chunk text width in display
            if curWidth + chunkWidth > targetWidth then -- Truncate chunk text
                chunkText = truncate(chunkText, targetWidth - curWidth) -- Truncate chunk text
                table.insert(newVirtText, { chunkText, chunk[2] }) -- Add truncated chunk text to new virt text table
                chunkText = chunkText .. suffix -- Add fold icon to truncated chunk text
                break -- Break loop
            end
            table.insert(newVirtText, chunk) -- Add chunk text to new virt text table if not truncated
            curWidth = curWidth + chunkWidth -- Add chunk text width to current width
        end

        if curWidth <= targetWidth then                      -- Add fold icon if not truncated
            table.insert(newVirtText, { suffix, 'NonText' }) -- Add fold icon to new virt text table
        end

        return newVirtText
    end
})

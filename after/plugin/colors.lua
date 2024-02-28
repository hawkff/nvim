function ColorMyPencils(color)
    color = color or "carbonfox"
    vim.cmd.colorscheme(color) -- set the colorscheme


    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })      -- set the background to transparent
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- set the background to transparent for floating windows (e.g. lsp diagnostics)
end

ColorMyPencils()

vim.api.nvim_set_keymap('n', '<leader>pcp', ':lua ColorMyPencils()<CR> ', { noremap = true, desc = "ColorMyPencils" })

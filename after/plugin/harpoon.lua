local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add current file to Harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle harpoon's quick menu" })

------------------------------------------------------------------------------------------------------------------------
-- navigation bindings for quick_menu
-- vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { desc = "Navigate to 1st file in Harpoon menu" })
-- vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { desc = "Navigate to 2nd file in Harpoon menu" })
-- vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { desc = "Navigate to 3rd file in Harpoon menu" })
-- vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { desc = "Navigate to 4th file in Harpoon menu" })
-- vim.keymap.set("n", "<C-5>", function() ui.nav_file(5) end, { desc = "Navigate to 5th file in Harpoon menu" })
-- vim.keymap.set("n", "<C-6>", function() ui.nav_file(6) end, { desc = "Navigate to 6th file in Harpoon menu" })
-- vim.keymap.set("n", "<C-7>", function() ui.nav_file(7) end, { desc = "Navigate to 7th file in Harpoon menu" })
-- vim.keymap.set("n", "<C-8>", function() ui.nav_file(8) end, { desc = "Navigate to 8th file in Harpoon menu" })
-- vim.keymap.set("n", "<C-9>", function() ui.nav_file(9) end, { desc = "Navigate to 9th file in Harpoon menu" })
------------------------------------------------------------------------------------------------------------------------

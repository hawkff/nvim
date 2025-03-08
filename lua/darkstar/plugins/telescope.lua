return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- Optional FZF native sorter - will be used if available
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                -- Only include this dependency if make and gcc/clang are available
                return vim.fn.executable("make") == 1 and
                       (vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1)
            end
        },
    },
    event = "VeryLazy",
    config = function()
        -- Fix for path_expand error
        local has_telescope, telescope = pcall(require, "telescope")
        if not has_telescope then
            return
        end

        -- Check if FZF is available
        local has_fzf = pcall(require, "telescope._extensions.fzf")

        -- Add telescope-specific highlights
        vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = "#ff00ff", bold = true })

        -- Build the telescope configuration
        local telescope_config = {
            defaults = {
                -- Use a more descriptive prompt prefix
                prompt_prefix = "🔍 ",
                selection_caret = "❯ ",

                -- Better window appearance
                layout_config = {
                    horizontal = {
                        width = 0.9,
                        height = 0.9,
                        preview_width = 0.6,
                    },
                    vertical = {
                        width = 0.9,
                        height = 0.9,
                        preview_height = 0.5,
                    },
                },

                -- Better sorting and results display
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                path_display = { "truncate" },

                -- Use ripgrep if available, but don't fail if not
                vimgrep_arguments = (function()
                    -- Check if ripgrep is installed
                    local has_rg = vim.fn.executable("rg") == 1
                    if has_rg then
                        return {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "--hidden",     -- search hidden files/directories
                            "--glob=!.git/" -- but exclude .git directory
                        }
                    else
                        -- Fall back to grep if ripgrep isn't available
                        return {
                            "grep",
                            "--color=never",
                            "--line-number",
                            "-r"
                        }
                    end
                end)(),

                -- Better file navigation handling
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "target/",
                    "vendor/",
                    ".cache",
                    "%.o",
                    "%.a",
                    "%.out",
                    "%.class",
                    "%.pdf",
                    "%.mkv",
                    "%.mp4",
                    "%.zip"
                },

                -- Improved performance with history settings
                history = {
                    path = vim.fn.stdpath("data") .. "/telescope_history.json",
                    limit = 100,
                },

                mappings = {
                    i = {
                        ["<C-h>"] = "which_key",
                        -- Navigate preview window
                        ["<C-j>"] = require('telescope.actions').move_selection_next,
                        ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        -- Move through history
                        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
                        ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
                        -- Clear input field
                        ["<C-u>"] = false,
                        -- Delete buffer from buffers picker
                        ["<C-x>"] = require('telescope.actions').delete_buffer,
                        -- Send to quickfix list
                        ["<C-q>"] = require('telescope.actions').send_to_qflist,
                    },
                    n = {
                        ["q"] = require('telescope.actions').close,
                        ["<C-c>"] = require('telescope.actions').close,
                        ["<Esc>"] = require('telescope.actions').close,
                        ["<C-x>"] = require('telescope.actions').delete_buffer,
                        ["<C-q>"] = require('telescope.actions').send_to_qflist,
                    }
                }
            },

            pickers = {
                find_files = {
                    hidden = true,     -- find hidden files
                    follow = true,     -- follow symlinks
                    no_ignore = false, -- respect .gitignore

                    -- Check if fd/rg is available and use it, otherwise fallback
                    find_command = (function()
                        if vim.fn.executable("fd") == 1 then
                            return { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
                        elseif vim.fn.executable("rg") == 1 then
                            return { "rg", "--files", "--hidden", "--glob", "!.git/*" }
                        end
                        -- Let Telescope use its defaults if neither is available
                        return nil
                    end)()
                },

                live_grep = {
                    additional_args = function()
                        return { "--hidden", "--glob", "!.git/*" }
                    end
                },

                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = require('telescope.actions').delete_buffer,
                        }
                    }
                },

                help_tags = {
                    layout_config = {
                        preview_width = 0.65
                    }
                }
            },
        }

        -- If FZF native extension is available, add FZF configuration to make searches
        -- significantly faster
        if has_fzf then
            -- Add FZF extension configuration
            telescope_config.extensions = telescope_config.extensions or {}
            telescope_config.extensions.fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            }
        end

        -- Initialize telescope with the configuration
        telescope.setup(telescope_config)

        -- Load extensions (only if they're available)
        if has_fzf then
            pcall(telescope.load_extension, 'fzf')
        end

        -- Set up keymaps
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')

        -- Basic file operations (maintaining your existing keymaps)
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })

        -- Enhanced mappings that don't conflict
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Grep string" })

        -- Additional mappings from the original configuration
        vim.keymap.set('n', '<leader>fd', function()
            builtin.find_files(themes.get_dropdown({ previewer = false, winblend = 10 }))
        end, { desc = "Find files (dropdown)" })

        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
        vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, { desc = "Search current buffer" })
        vim.keymap.set('n', '<leader>f\"', builtin.registers, { desc = "Search registers" })
        vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = "Search marks" })
        vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Search commands" })
        vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = "Search treesitter symbols" })

        -- Diagnostics (now renamed to avoid the conflict with dropdown)
        vim.keymap.set('n', '<leader>fx', builtin.diagnostics, { desc = "Search diagnostics" })

        -- Notify when FZF is active
        if has_fzf then
            vim.notify("Telescope: FZF native sorter is active", vim.log.levels.INFO)
        end
    end
}

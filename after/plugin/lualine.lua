local lualine = require("lualine")
-- Define your custom colors

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'codedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { -- Filetypes to disable lualine for
            statusline = {},   -- only ignores the ft for statusline
            winbar = {},       -- only ignores the ft for winbar.
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 300,
            tabline = 300,
            winbar = 300,
        }
    },
    sections = {
        --------------------
        lualine_a = {
            --
            'mode',
            --
            {
                'tabs',
                tab_max_length = 40,            -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
                max_length = vim.o.columns / 3, -- Maximum width of tabs component.
                -- Note:
                -- It can also be a function that returns
                -- the value of `max_length` dynamically.
                mode = 0, -- 0: Shows tab_nr
                -- 1: Shows tab_name
                -- 2: Shows tab_nr + tab_name

                path = 0, -- 0: just shows the filename
                -- 1: shows the relative path and shorten $HOME to ~
                -- 2: shows the full path
                -- 3: shows the full path and shorten $HOME to ~

                -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
                use_mode_colors = true,

                tabs_color = {
                    -- Same values as the general color option can be used here.
                    -- active = 'lualine_{section}_normal',     -- Color for active tab.
                    -- inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
                },

                show_modified_status = false, -- Shows a symbol next to the tab name if the file has been modified.
                symbols = {
                    modified = '🐣', -- Text to show when the file is modified.
                    readonly = '🔒', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '❓', -- Text to show for unnamed buffers.
                    newfile = '🌱', -- Text to show for newly created file before first write
                },
            },
            --
            {
                'windows',
                show_filename_only = true,    -- Shows shortened relative path when set to false.
                show_modified_status = false, -- Shows indicator when the window is modified.

                mode = 1,                     -- 0: Shows window name
                -- 1: Shows window index
                -- 2: Shows window name + window index

                max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
                -- it can also be a function that returns
                -- the value of `max_length` dynamically.
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    fzf = 'FZF',
                    alpha = 'Alpha'
                }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )

                -- disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled

                -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
                use_mode_colors = true,

                windows_color = {
                    -- Same values as the general color option can be used here.
                    -- active = 'lualine_{section}_normal',     -- Color for active window.
                    -- inactive = 'lualine_{section}_inactive', -- Color for inactive window.
                },
            },
            --
        },
        --------------------
        lualine_b = {
            --
            {
                'copilot',
                -- Default values
                symbols = {
                    status = {
                        icons = {
                            enabled = "",
                            disabled = "",
                            warning = "",
                            unknown = ""
                        },
                        hl = {
                            enabled = "#50FA7B",
                            disabled = "#6272A4",
                            warning = "#FFB86C",
                            unknown = "#FF5555"
                        }
                    },
                    spinners = require("copilot-lualine.spinners").dots,
                    spinner_color = "#6272A4"
                },
                show_colors = false,
                show_loading = true
            },
            --
            'branch',
            --
            {
                'diff',
                colored = false, -- Displays a colored diff status if set to true
                diff_color = {
                    -- Same color values as the general color option can be used here.
                    added    = 'LuaLineDiffAdd', -- Changes the diff's added color
                    modified = 'LuaLineDiffChange', -- Changes the diff's modified color
                    removed  = 'LuaLineDiffDelete', -- Changes the diff's removed color you
                },
                symbols = { added = '💡', modified = '📌', removed = '🗑️' }, -- Changes the symbols used by the diff.
                source = nil, -- A function that works as a data source for diff.
                -- It must return a table as such:
                --   { added = add_count, modified = modified_count, removed = removed_count }
                -- or nil on failure. count <= 0 won't be displayed.
            },
            --
            { 'diagnostics',
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    -- error = { fg = '#ff0000' }, -- Red color for errors
                    -- warn = { fg = '#ffae00' },  -- Orange color for warnings
                    -- info = { fg = '#00ffae' },  -- Cyan color for info
                    hint = { fg = '#00ffae' }, -- Cyan color for hints
                },
                symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                colored = true,           -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false,   -- Show diagnostics even if there are none.
            },
            --
        },
        --------------------
        lualine_c = {
            --
            {
                'filename',
                file_status = true,    -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                path = 0,              -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory
                -- 4: Filename and parent dir, with tilde as the home directory

                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = '🐣', -- Text to show when the file is modified.
                    readonly = '🔒', -- Text to show when the file is non-modifiable or readonly.
                    unnamed = '❓', -- Text to show for unnamed buffers.
                    newfile = '🌱', -- Text to show for newly created file before first write
                },
            },
            --
            { "vim.g.xcodebuild_scheme" },
            --
            { "vim.g.xcodebuild_config	" },
        },
        --------------------
        lualine_x = {
            --
            -- { "'󰙨 ' .. vim.g.xcodebuild_test_plan" },
            --
            { "vim.g.xcodebuild_platform == 'macOS' and '  macOS' or ' ' .. vim.g.xcodebuild_device_name" },
            --
            { "' ' .. vim.g.xcodebuild_os" },
            --

            --

            --
            { 'filetype', icon_only = false }
        },
        --------------------
        lualine_y =
        {
            --
            'encoding',
            --

            --
        },
        --------------------
        lualine_z =
        {
            --
            {
                'fileformat',
                symbols = {
                    unix = '', -- e712
                    dos = '', -- e70f
                    mac = '', -- e711
                }
            },
            --
            'progress',
            --
            'location',
            --
        }
    },
    ---------------------------------------
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    ---------------------------------------
    tabline = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    ---------------------------------------
    winbar = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    ---------------------------------------

    inactive_winbar = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
    },
    ---------------------------------------
    extensions = {}
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the plugin does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({})

            local group = vim.api.nvim_create_augroup("darkstar-treesitter", {})
            local install_pending = {} -- keyed by bufnr, guards the in-flight window

            -- Start highlighting for every filetype with an installed parser.
            -- Missing parsers are installed on demand (old auto_install = true).
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(ev)
                    local lang = vim.treesitter.language.get_lang(ev.match)
                    if not lang then
                        return
                    end

                    -- already highlighting, or an install is already in
                    -- flight for this buffer, nothing to do
                    if vim.treesitter.highlighter.active[ev.buf] or install_pending[ev.buf] then
                        return
                    end

                    -- pcall: language.add can throw from the C loader on
                    -- parser ABI mismatch (e.g. mid-:TSUpdate); it returns
                    -- nil (not an error) when no parser exists
                    local ok, added = pcall(vim.treesitter.language.add, lang)
                    if ok and added then
                        vim.treesitter.start(ev.buf, lang)
                        return
                    end

                    if not vim.tbl_contains(ts.get_available(), lang) then
                        return
                    end

                    install_pending[ev.buf] = true
                    ts.install({ lang }):await(function(err)
                        install_pending[ev.buf] = nil
                        if err or not vim.api.nvim_buf_is_valid(ev.buf) then
                            return
                        end
                        -- the await callback runs off the main loop, where
                        -- treesitter.start is restricted; defer it
                        vim.schedule(function()
                            if vim.api.nvim_buf_is_valid(ev.buf) then
                                pcall(vim.treesitter.start, ev.buf, lang)
                            end
                        end)
                    end)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
}

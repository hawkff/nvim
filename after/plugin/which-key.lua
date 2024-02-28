local wk = require("which-key")
--------------------------------------------
-- variables for descriptions
local desc_c = "Compile"
-- local desc_d = "DAP commands"
local desc_f = "format + Formating & Scope Section"
local desc_g = "Git Section"
local desc_p = "Project"
local desc_v = "LSP & Vi"
--------------------------------------------
-- Strings
local diagnost = "Diagnostics"
--------------------------------------------
-- Mappings for '<leader>' prefix

local mappings = {
    c = {
        name = desc_c,
    },
    --------------------------------------------

    d = {
        name = desc_d,
    },
    --------------------------------------------

    f = {
        name = desc_f,
        m = { "Rain" },
    },
    --------------------------------------------

    g = {
        name = desc_g,
        p = { "Push" },
        P = { "Pull --rebase" },
        t = { "Push -u origin" },
    },
    --------------------------------------------

    p = {
        name = desc_p,
        c = { "Colors" },
    },
    --------------------------------------------

    v = {
        name = desc_v,
        c = {
            "Code",
            a = { "Action" },
        },

        d = {
            "Diagnostics",
        },

        p = {
            name = "Properties",
        },

        r = {
            "References & Rename",
            r = { "Show references" },
            n = { "Rename Under-Cursor Symbol Workspace-wide" },
        },

        w = {
            "Workspace",
            s = { "Search for symbol in workspace" },
        },
    },
    --------------------------------------------

    --------------------------------------------

}

-- Registering the mappings with which-key
wk.register(mappings, { prefix = "<leader>" })

--------------------------------------------
local v_mappings = {
    f = {
        name = desc_f,
        m = { "Rain" },
    },
}
-- Registering the mappings with which-key for visual mode
wk.register(v_mappings, { prefix = "<leader>", mode = "v" })

--------------------------------------------
-- Mappings for '[' prefix
local mappings_open_bracket = {
    d = {
        diagnost,
    },
}
--Registering the mappings for '[' prefix
wk.register(mappings_open_bracket, { prefix = "[" })

--------------------------------------------
-- Mappings for ']' prefix
local mappings_close_bracket = {
    d = {
        diagnost,
    },
}
--Registering the mappings for ']' prefix
wk.register(mappings_close_bracket, { prefix = "]" })

--------------------------------------------

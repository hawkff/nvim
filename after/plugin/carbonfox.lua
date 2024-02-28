-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "italic",
      constants = "NONE",
      functions = "italic",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes =
  {
    -- Palettes are the base color defines of a colorscheme.
    -- You can override these palettes for each colorscheme defined by nightfox.
    -- Everything defined under `all` will be applied to each style.
  carbonfox = {
    -- Each palette defines these colors:
    --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
    --
    -- These colors have 3 shades: base, bright, and dim
    --
    -- Defining just a color defines it's base color
    red = { base = "#e11021", bright = "#d40617", dim = "#CF0000" },
    green = { base = "#54E346", bright = "#5AC199", dim = "#005F00" },
    yellow = { base = "#FFEA20", bright = "#F8FF95", dim = "#e1e318" },
    blue = { base = "#BF81FF", bright = "#837DFF", dim = "#4eb9f4" },
    magenta = { base = "#DD58D6", bright = "#E90064", dim = "#2eada7" },
    cyan = { base = "#3AA6B9", bright = "#6cc38e", dim = "#28FFBF" },
    white = { base = "#ffffff", bright = "#ffffff", dim = "#FF8080" },
    orange = { base = "#FF8400", bright = "#FF4A4A", dim = "#FF6D28" },
    pink = { base = "#FF52A2", bright = "#f94bae", dim = "#EE81C3" },

    comment = "#9ea6b0", -- comment is the definition of the comment color.
    bg1 = "#000000",
  },
    -- A specific style's value will be used over the `all`'s value
    -- Defining multiple shades is done by passing a table
        -- blue = { base = "#4d688e", bright = "#4e75aa", dim = "#485e7d" },
    -- A palette also defines the following:
        --   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
    --
    -- These are the different foreground and background shades used by the theme.
    -- The base bg and fg is 1, 0 is normally the dark alternative. The others are
    -- incrementally lighter versions.
        -- bg1 = "#2e3440",
    -- sel is different types of selection colors.
        -- sel0 = "#3e4a5b", -- Popup bg, visual selection bg
        -- sel1 = "#4f6074", -- Popup sel bg, search bg
  },
  specs =
  {
-- Spec's (specifications) are a mapping of palettes to logical groups that will be
-- used by the groups. Some examples of the groups that specs map would be:
--   - syntax groups (functions, types, keywords, ...)
--   - diagnostic groups (error, warning, info, hints)
--   - git groups (add, removed, changed)
--
-- You can override these just like palettes
  -- As with palettes, the values defined under `all` will be applied to every style.
  carbonfox = {
    syntax = {
      -- Specs allow you to define a value using either a color or template. If the string does
      -- start with `#` the string will be used as the path of the palette table. Defining just
      -- a color uses the base version of that color.
      -- Adding either `.bright` or `.dim` will change the value
      bracket = "yellow.dim", -- Brackets and Punctuation
      builtin0 = "cyan", --Builtin variable
      builtin1 = "orange.bright", -- Builtin type
      builtin2 = "red", -- Builtin const
      comment = "green.dim", -- Comment
      conditional = "pink.bright", -- Conditional and loop
      const = "blue", -- Constants, imports and booleans
      dep = "orange", -- Deprecated
      field = "pink.bright", -- Field, member variable of a class or struct
      func = "cyan.dim", -- Functions and Titles
      ident = "pink.bright", -- Identifiers, the names used for variables, functions, classes, etc
      keyword = "pink.bright", -- Keywords
      number = "blue.bright", -- Numbers
      operator = "magenta.bright", -- Operators
      preproc = "pink.bright", -- PreProc
      regex = "blue.dim", -- Regex
      statement = "pink.bright", -- Statements
      string = "green.bright", -- Strings
      type = "magenta.dim", -- Types
      variable = "blue.dim", -- Variables
    },
    -- git = {
      -- A color define can also be used
      -- changed = "#f4a261",
    -- },
  },
      -- As with palettes, a specific style's value will be used over the `all`'s value.
      -- operator = "orange",
  },
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme carbonfox")
require('nightfox').compile() -- lua api version
vim.api.nvim_set_keymap('n', '<leader>pcc', ':color carbonfox<CR> ', { noremap = true, desc = "Set CarbonFox Color" })

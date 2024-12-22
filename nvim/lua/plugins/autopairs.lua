local openNRegx = ".[^%w%p]"
local closeNRegx = "[^%w%p]."
local opencloseNRegx = "[^%w%p][^%w%p]"

return {
    {
        "echasnovski/mini.pairs",
        enabled = false,
        event = "VeryLazy",
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- stylua: ignore
            mappings = {
                ['('] = { action = 'open', pair = '()', neigh_pattern = openNRegx },
                ['['] = { action = 'open', pair = '[]', neigh_pattern = openNRegx },
                ['{'] = { action = 'open', pair = '{}', neigh_pattern = openNRegx },

                [')'] = { action = 'close', pair = '()', neigh_pattern = closeNRegx },
                [']'] = { action = 'close', pair = '[]', neigh_pattern = closeNRegx },
                ['}'] = { action = 'close', pair = '{}', neigh_pattern = closeNRegx },
                ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = opencloseNRegx, register = { cr = false } },
                ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = opencloseNRegx, register = { cr = false } },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = opencloseNRegx, register = { cr = false } },
            },
        },
    },
    {
        "m4xshen/autoclose.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                disable_when_touch = true,
                pair_spaces = true,
            },
            keys = {
                [")"] = { escape = false, close = false, pair = "()" },
                ["]"] = { escape = false, close = false, pair = "[]" },
                ["}"] = { escape = false, close = false, pair = "{}" },

                ["'"] = {
                    escape = false,
                    close = true,
                    pair = "''",
                    disabled_filetypes = { "markdown" },
                },
                ["`"] = { escape = false, close = true, pair = "``" },
                [">"] = { escape = false, close = false, pair = "><" },
            },
        },
    },
}

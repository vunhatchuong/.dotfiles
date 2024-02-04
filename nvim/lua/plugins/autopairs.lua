local openNRegx = ".[^%a\\]"
local closeNRegx = "[^%a\\]."

return {
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            -- stylua: ignore
            mappings = {
                ['('] = { action = 'open', pair = '()', neigh_pattern = openNRegx },
                ['['] = { action = 'open', pair = '[]', neigh_pattern = openNRegx },
                ['{'] = { action = 'open', pair = '{}', neigh_pattern = openNRegx },

                [')'] = { action = 'close', pair = '()', neigh_pattern = closeNRegx },
                [']'] = { action = 'close', pair = '[]', neigh_pattern = closeNRegx },
                ['}'] = { action = 'close', pair = '{}', neigh_pattern = closeNRegx },
                ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = closeNRegx, register = { cr = false } },
                ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = closeNRegx, register = { cr = false } },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = closeNRegx, register = { cr = false } },
            },
        },
    },
}

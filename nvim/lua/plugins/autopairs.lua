local openNRegx = ".[^%w%p]"
local closeNRegx = "[^%w%p]."
local opencloseNRegx = "[^%w%p][^%w%p]"

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
                ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = opencloseNRegx, register = { cr = false } },
                ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = opencloseNRegx, register = { cr = false } },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = opencloseNRegx, register = { cr = false } },
            },
        },
    },
}

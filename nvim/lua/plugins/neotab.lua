local all_pairs = {
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "<", close = ">" },
}

return {
    {
        "kawre/neotab.nvim",
        event = "InsertEnter",
        --- @module "neotab"
        --- @diagnostic disable: missing-fields
        opts = {
            smart_punctuators = {
                enabled = true,
                semicolon = { -- Put semicolon(;) at the right place
                    enabled = true,
                    ft = { "zig", "c", "cpp", "java" },
                },
                escape = { -- Insert char at the right place
                    enabled = true,
                    ---@type table<string, ntab.trigger>
                    triggers = {
                        ["+"] = { pairs = all_pairs, format = " %s " },
                        ["-"] = { pairs = all_pairs, format = " %s " },
                        ["*"] = { pairs = all_pairs, format = " %s " },
                        ["/"] = { pairs = all_pairs, format = " %s " },

                        [","] = { pairs = all_pairs, format = "%s " },
                        [";"] = { pairs = all_pairs, format = "%s" },
                        ["="] = {
                            pairs = { { open = "(", close = ")" } },
                            format = " %s> ", -- ` => `
                            -- string.match(text_between_pairs, cond)
                            cond = "^$", -- match only pairs with empty content
                        },
                    },
                },
            },
        },
    },
}

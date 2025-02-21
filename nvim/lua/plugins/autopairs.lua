return {
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        opts = {
            options = {
                disable_when_touch = true,
                pair_spaces = true,
                -- matches a single char in the list: %w([{'" (case sensitive)
                touch_regex = "[%w(%[{'\"]",
            },
            keys = {
                ["`"] = { escape = false, close = true, pair = "``" },
            },
        },
    },
}

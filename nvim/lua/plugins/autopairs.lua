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
    { -- Fast wrap pairs
        "xzbdmw/clasp.nvim",
        keys = {
            {
                "<C-l>",
                mode = { "n", "i" },
                desc = "Clasp",
            },
        },
        opts = {},
        config = function(_, opts)
            require("clasp").setup(opts)

            -- jumping from smallest region to largest region
            vim.keymap.set({ "n", "i" }, "<C-l>", function()
                require("clasp").wrap("next")
            end)
            -- jumping from largest region to smallest region
            vim.keymap.set({ "n", "i" }, "<C-l>", function()
                require("clasp").wrap("prev")
            end)

            -- Exclude nodes whose end row is not current row
            vim.keymap.set({ "n", "i" }, "<c-l>", function()
                require("clasp").wrap("next", function(nodes)
                    local n = {}
                    for _, node in ipairs(nodes) do
                        if
                            node.end_row
                            == vim.api.nvim_win_get_cursor(0)[1] - 1
                        then
                            table.insert(n, node)
                        end
                    end
                    return n
                end)
            end)
        end,
    },
}

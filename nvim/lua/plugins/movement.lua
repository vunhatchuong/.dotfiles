return {
    {
        "cbochs/grapple.nvim",
        event = "VeryLazy",
        config = function()
            local grapple = require("grapple")
            local keymap = vim.keymap.set
            local function mark_file()
                grapple.toggle()
                vim.notify("󱡁 Toggle mark")
            end

            grapple.setup()

            -- stylua: ignore start
            keymap("n", "<leader>a", function() mark_file() end)
            keymap("n", "<TAB>", function() grapple.toggle_tags() end)
            keymap("n", "<leader>1", function() grapple.select({ index = 1 }) end)
            keymap("n", "<leader>2", function() grapple.select({ index = 2 }) end)
            keymap("n", "<leader>3", function() grapple.select({ index = 3 }) end)
            keymap("n", "<leader>4", function() grapple.select({ index = 4 }) end)
            keymap("n", "<leader>5", function() grapple.select({ index = 5 }) end)
            -- stylua: ignore end
        end,
    },
    {
        "cbochs/portal.nvim",
        keys = function()
            local portal_builtin = require("portal.builtin")
            return {
                {
                    "<C-o>",
                    function()
                        local results = require("portal").search(
                            portal_builtin.jumplist.query({
                                direction = "forward",
                            })
                        )
                        if vim.tbl_isempty(results) then
                            require("portal").tunnel(
                                portal_builtin.jumplist.query({
                                    direction = "backward",
                                })
                            )
                            return
                        end
                        require("portal").tunnel(portal_builtin.jumplist.query({
                            direction = "forward",
                        }))
                    end,
                },
            }
        end,
        opts = {
            filter = function(v)
                return v.buffer == vim.fn.bufnr()
            end,
            select_first = true,
            escape = {
                ["<esc>"] = true,
                ["q"] = true,
            },
            window_options = {
                relative = "cursor",
                width = 80,
                height = 4,
                col = 10,
                focusable = false,
                border = "rounded",
                noautocmd = true,
            },
        },
    },
    {
        "ggandor/leap.nvim",
        dependencies = {
            {
                "ggandor/flit.nvim",
                config = function()
                    require("flit").setup({
                        -- A string like "nv", "nvo", "o", etc.
                        labeled_modes = "nv",
                    })
                end,
            },
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
        },
        config = function()
            local leap = require("leap")
            leap.add_default_mappings(true)
            -- Greying out the search area
            vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#777777" })
        end,
    },
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {},
    },
}

return {
    {
        "cbochs/grapple.nvim",
        keys = function()
            local grapple = require("grapple")
            local function mark_file()
                grapple.toggle()
                vim.notify("󱡁 Toggle mark")
            end
            return {
                -- stylua: ignore start
                { "<leader>a", function() mark_file() end },
                { "<TAB>", function() grapple.toggle_tags() end },
                { "<leader>1", function() grapple.select({ index = 1 }) end },
                { "<leader>2", function() grapple.select({ index = 2 }) end },
                { "<leader>3", function() grapple.select({ index = 3 }) end },
                { "<leader>4", function() grapple.select({ index = 4 }) end },
                { "<leader>5", function() grapple.select({ index = 5 }) end },
                -- stylua: ignore end
            }
        end,
        opts = {},
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
        "echasnovski/mini.jump2d",
        event = "VeryLazy",
        keys = {
            {
                "<CR>",
                function()
                    require("mini.jump2d").start(
                        require("mini.jump2d").builtin_opts.word_start
                    )
                end,
            },
        },
        opts = {
            -- Characters used for labels of jump spots (in supplied order)
            labels = "arstneioqwfpgh",
            view = {
                dim = true,
                n_steps_ahead = 10,
            },
            allowed_windows = {
                not_current = false,
            },
            mappings = {
                start_jumping = "",
            },
        },
    },
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.operators",
        event = "VeryLazy",
        opts = {
            evaluate = { prefix = "" },
            exchange = { prefix = "" },
            multiply = { prefix = "" },
            replace = { prefix = "gs" }, -- go substitute
            sort = { prefix = "" },
        },
    },
}

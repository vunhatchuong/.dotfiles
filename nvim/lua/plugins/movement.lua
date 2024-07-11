return {
    {
        "cbochs/grapple.nvim",
        event = "VeryLazy",
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
        "folke/flash.nvim",
        opts = {
            multi_window = false,
            exclude = {
                "notify",
                "cmp_menu",
                "flash_prompt",
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
            },
            jump = {
                autojump = true,
            },
            modes = {
                char = {
                    enabled = false,
                    jump_labels = true,
                },
                treesitter = {
                    highlight = {
                        backdrop = true,
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            -- "f", "F", "t", "T",
            -- Replace default 'f' bind (Default 's')
            { "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "echasnovski/mini.move",
        event = "VeryLazy",
        opts = {},
    },
}

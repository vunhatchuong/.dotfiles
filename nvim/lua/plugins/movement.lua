return {
    {
        "cbochs/grapple.nvim",
        keys = function()
            local function mark_file()
                require("grapple").toggle()
                vim.notify("󱡁 Toggle mark")
            end
            return {
                -- stylua: ignore start
                { "<leader>a", function() mark_file() end },
                { "<TAB>", "<cmd>Grapple toggle_tags<cr>" },
                { "<leader>1", "<cmd>Grapple select index=1<cr>" },
                { "<leader>2", "<cmd>Grapple select index=2<cr>" },
                { "<leader>3", "<cmd>Grapple select index=3<cr>" },
                { "<leader>4", "<cmd>Grapple select index=4<cr>" },
                { "<leader>5", "<cmd>Grapple select index=5<cr>" },
                -- stylua: ignore end
            }
        end,
        opts = {},
    },
    {
        "cbochs/portal.nvim",
        keys = function()
            return {
                {
                    "<C-o>",
                    function()
                        local results = require("portal").search(
                            require("portal.builtin").jumplist.query({
                                direction = "forward",
                            })
                        )
                        if vim.tbl_isempty(results) then
                            require("portal").tunnel(
                                require("portal.builtin").jumplist.query({
                                    direction = "backward",
                                })
                            )
                            return
                        end
                        require("portal").tunnel(
                            require("portal.builtin").jumplist.query({
                                direction = "forward",
                            })
                        )
                    end,
                },
            }
        end,
        opts = {
            filter = function(v)
                return v.buffer == vim.fn.bufnr()
            end,
            select_first = true,
            escape = { ["<esc>"] = true, ["q"] = true },
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
            view = { dim = true, n_steps_ahead = 10 },
            allowed_windows = { not_current = false },
            mappings = { start_jumping = "" },
        },
    },
    {
        "echasnovski/mini.move",
        keys = { { "<M-j>" }, { "<M-h>" } },
        opts = {},
    },
    {
        "echasnovski/mini.operators",
        keys = { { "gs" } },
        opts = {
            evaluate = { prefix = "" },
            exchange = { prefix = "" },
            multiply = { prefix = "" },
            replace = { prefix = "gs" }, -- go substitute
            sort = { prefix = "" },
        },
    },
    {
        "glepnir/flybuf.nvim",
        keys = { { "gb", "<CMD>FlyBuf<CR>", desc = "Open buffer menu" } },
        opts = {},
    },
}

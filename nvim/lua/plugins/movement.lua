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
                { "<TAB>",     ":Grapple toggle_tags<CR>" },
                { "<leader>1", ":Grapple select index=1<CR>" },
                { "<leader>2", ":Grapple select index=2<CR>" },
                { "<leader>3", ":Grapple select index=3<CR>" },
                { "<leader>4", ":Grapple select index=4<CR>" },
                { "<leader>5", ":Grapple select index=5<CR>" },
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
        "xiaoshihou514/squirrel.nvim",
        -- stylua: ignore
        keys = {
            { "f",    function() require("squirrel.hop").hop_linewise({ head = true, tail = true }) end },
            { "<CR>", function() require("squirrel.hop").hop({ head = true, tail = true }) end },
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
        keys = { { "gb", ":FlyBuf<CR>", desc = "Open buffer menu" } },
        opts = {},
    },
    { -- Move in and out of brackets
        "ysmb-wtsg/in-and-out.nvim",
        -- Doesn't work on Windows and WSL :\
        enabled = vim.fn.has("Linux") == 1 or vim.fn.has("wsl") == 1,
        event = "VeryLazy",
        config = function()
            vim.keymap.set("i", "<C-CR>", function()
                require("in-and-out").in_and_out()
            end, { desc = "In and out" })
        end,
    },
    { -- Don't touch anything! Has to config this way
        "mfussenegger/nvim-treehopper",
        keys = { { "<CR>", mode = { "x", "o" } } },
        config = function()
            vim.keymap.set({ "o" }, "<CR>", function()
                require("tsht").nodes()
            end, { noremap = false, expr = false, silent = true })
            vim.keymap.set(
                { "x" },
                "<CR>",
                ":lua require('tsht').nodes()<CR>",
                { noremap = true, expr = false, silent = true }
            )
        end,
    },
}

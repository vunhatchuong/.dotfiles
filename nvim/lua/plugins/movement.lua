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
                { "<leader>m", "<CMD>Grapple toggle_tags<CR>" },
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
        keys = {
            {
                "<TAB>",
                function()
                    require("in-and-out").in_and_out()
                end,
                mode = "n",
            },
        },
        opts = { additional_targets = { "<", ">" } },
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
    {
        "vunhatchuong/telescope-jumps.nvim",
        dependencies = { { "nvim-telescope/telescope.nvim" } },
        keys = { { "<C-o>", ":Telescope jumps jumpbuff<CR>" } },
        opts = {
            extensions = {
                jumps = {
                    -- max_results = 5,
                    line_distance = 3,
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("jumps")
        end,
    },
}

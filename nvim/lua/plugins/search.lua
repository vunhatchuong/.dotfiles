return {
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        keys = {
            {
                "<leader>st",
                function()
                    require("grug-far").grug_far()
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
            {
                "<leader>ss",
                function()
                    require("grug-far").grug_far({
                        prefills = {
                            search = vim.fn.expand("<cword>"),
                            paths = vim.fn.expand("%"),
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search current word",
            },
        },
        opts = {
            startInInsertMode = false,
            transient = true,
            keymaps = {
                qflist = false,
                close = { n = "<localleader>q" },
                historyAdd = false,
            },
            reportDuration = false,
            history = { autoSave = { enabled = false } },
        },
    },
    {
        "cshuaimin/ssr.nvim",
        keys = {
            {
                "<leader>sf",
                function()
                    require("ssr").open()
                end,
                mode = { "n", "x" },
            },
        },
        opts = {},
    },
    {
        "chrisgrieser/nvim-rip-substitute",
        keys = {
            {
                "<leader>s",
                function()
                    require("rip-substitute").sub()
                end,
                mode = { "n", "x" },
                desc = "Rip Substitute",
            },
        },
    },
}

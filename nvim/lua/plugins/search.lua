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
                desc = "Search and Replace",
            },
            {
                "<leader>ss",
                function()
                    require("grug-far").grug_far({
                        prefills = { search = vim.fn.expand("<cword>") },
                    })
                end,
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
}

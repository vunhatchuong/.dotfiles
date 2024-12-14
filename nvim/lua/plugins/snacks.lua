return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scratch = { ft = "markdown" },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        styles = {
            terminal = { keys = { q = false, gf = false, term_normal = false } },
        },
    },
    keys = {
        {
            "<leader>ps",
            function()
                require("snacks").profiler.scratch()
            end,
            desc = "Profiler Scratch Buffer",
        },
        {
            "<leader>n",
            function()
                require("snacks").scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>wf",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Maximize window",
        },
        {
            "<C-\\>",
            function()
                Snacks.terminal.toggle(nil, { cwd = Snacks.git.get_root() })
            end,
            desc = "Toggle term",
        },
    },
}

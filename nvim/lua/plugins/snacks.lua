return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
        require("snacks").toggle.profiler():map("<leader>pp")
        require("snacks").toggle.profiler_highlights():map("<leader>ph")
        return {
            notifier = { enabled = true },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false }, -- we set this in options.lua
            scratch = {
                ft = "markdown",
            },
        }
    end,
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
    },
}

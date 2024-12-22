return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    --- @diagnostic disable: missing-fields
    opts = {
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scratch = { ft = "markdown" },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = {
            win = {
                position = "float",
                wo = { winbar = "" },
            },
        },
        styles = {
            terminal = { keys = { q = false, gf = false, term_normal = false } },
        },
    },
    keys = {
        {
            "<leader>n",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>lg",
            function()
                Snacks.lazygit({ cwd = Snacks.git.get_root() })
            end,
            desc = "Lazygit (Root Dir)",
        },
        {
            "<C-\\>",
            function()
                Snacks.terminal.toggle(nil, { cwd = Snacks.git.get_root() })
            end,
            desc = "Term (Root Dir)",
        },
        {
            "<leader>ul",
            function()
                Snacks.toggle.line_number():toggle()
            end,
            desc = "Toggle line number",
        },
        {
            "<leader>wf",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Maximize window",
        },
    },
}

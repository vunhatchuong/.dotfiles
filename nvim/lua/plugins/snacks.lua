return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
        local nontext_hl = vim.api.nvim_get_hl(0, { name = "NonText" }).fg
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#ffffff" })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = nontext_hl })
        vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = nontext_hl })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = nontext_hl })
    end,
    ---@type snacks.Config
    --- @diagnostic disable: missing-fields
    opts = {
        input = { enabled = true },
        notifier = {
            enabled = true,
            sort = { "added" },
        },
        quickfile = { enabled = true },
        scratch = { ft = "markdown" },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        -- https://github.com/Bekaboo/dot/tree/master/.config/nvim
        dashboard = {
            enabled = true,
            width = 18,
            preset = {
                pick = "fzf-lua", ---@type "fzf-lua"|"telescope.nvim"|"mini.pick"

                header = [[
Neovim :: M Λ C R O - Editing made simple
                ]],
            },
            sections = {
                -- stylua: ignore start
                { hidden = true, icon = " ", key = "t", desc = "Find [T]ext", action = ":lua Snacks.dashboard.pick('live_grep')" },
                { hidden = true, icon = " ", key = "r", desc = "[R]ecent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                { hidden = true, icon = "󰒲 ", key = "l", desc = "[L]azy", action = ":Lazy" },
                -- stylua: ignore end

                { text = " ", padding = 12 },

                -- Header
                {
                    padding = 2,
                    text = {
                        { "Neovim :: M Λ C R O ", hl = "Normal" },
                        { "- Editing made simple", hl = "NonText" },
                    },
                    action = ":lua Snacks.dashboard.pick('files')",
                    key = "f",
                },

                -- Keys
                {
                    padding = 1,
                    text = {
                        { "  Find [F]ile", width = 19, hl = "NonText" },
                        { "  Find [T]ext", hl = "NonText" },
                    },
                    action = ":lua Snacks.dashboard.pick('files')",
                    key = "f",
                },
                {
                    padding = 1,
                    text = {
                        { " ", width = 3 },
                        { "  [N]ew File", width = 19, hl = "NonText" },
                        { "  [R]ecent File", hl = "NonText" },
                    },
                    action = ":ene | startinsert",
                    key = "n",
                },
                {
                    padding = 2,
                    text = {
                        { " ", width = 9 },
                        { "  [C]onfig", hl = "NonText" },
                        { " ", width = 8 },
                        { "󰒲  [L]azy", hl = "NonText" },
                        { " ", width = 14 },
                    },
                    action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    key = "c",
                },
                {
                    padding = 2,
                    text = {
                        { " ", width = 5 },
                        { "  [Q]uit", hl = "NonText" },
                    },
                    action = ":quitall",
                    key = "q",
                },

                -- Startup
                { section = "startup", padding = 1 },
                {
                    section = "terminal",
                    cmd = "printf ' '",
                    height = 15,
                },

                -- Footer
                {
                    text = {
                        [[
 Copyright (c) 2024 - M Λ C R O developers
                    ]],

                        hl = "NonText",
                    },
                },
            },

            formats = { key = { "" } },
        },
        terminal = {
            win = { position = "float", wo = { winbar = "" } },
        },
        styles = {
            terminal = { keys = { q = false, gf = false, term_normal = false } },
            input = {
                backdrop = true,
                row = math.ceil(vim.o.lines / 2) - 3,
            },
            notification = {
                border = vim.g.border_style,
                wo = { wrap = true },
            },
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
            "<leader>wf",
            function()
                Snacks.zen.zoom()
            end,
            desc = "Maximize window",
        },
    },
}

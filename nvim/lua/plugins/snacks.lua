return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function()
            vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "Text" })
            vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { link = "NonText" })
            vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { link = "NonText" })
            vim.api.nvim_set_hl(0, "SnacksDashboardKey", { link = "NonText" })
        end,
        ---@type snacks.Config
        --- @diagnostic disable: missing-fields
        opts = {
            input = { enabled = true },
            notifier = {
                timeout = 7000,
                enabled = true,
                sort = { "added" },
            },
            quickfile = { enabled = true },
            scratch = { ft = "markdown" },
            statuscolumn = { enabled = false }, -- we set this in options.lua
            terminal = {
                win = { position = "float", wo = { winbar = "" } },
            },
            styles = {
                -- terminal = { keys = { q = false, gf = false, term_normal = false } },
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
    },
    {
        "snacks.nvim",
        opts = {
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
                { hidden = true, icon = " ", key = "t", desc = "Find [T]ext", action = ":FzfLua live_grep_native" },
                { hidden = true, icon = " ", key = "r", desc = "[R]ecent Files", action = ":FzfLua oldfiles" },
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
                    },

                    -- Keys
                    {
                        padding = 1,
                        text = {
                            { "  Find [F]ile", width = 19, hl = "NonText" },
                            { "  Find [T]ext", hl = "NonText" },
                        },
                        action = ":FzfLua files",
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
        },
    },
}

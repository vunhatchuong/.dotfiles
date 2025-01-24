vim.g.snacks_animate = false
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
            indent = {
                enabled = true,
                indent = { enabled = false },
                animate = { enabled = false },
                scope = { char = "│", only_current = true },
            },
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
                    focusable = false,
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
            {
                "o",
                mode = "o",
                desc = "Delete outer scope",
                -- stylua: ignore
                function()
                    local operator = vim.v.operator
                    if operator == "d" then
                        local scope = require("snacks").scope.get()
                        if scope == nil then return "o" end

                        local top = scope.from
                        local bottom = scope.to

                        local ns = vim.api.nvim_create_namespace("border")

                        vim.api.nvim_buf_set_extmark(0, ns, top - 1, 0, {
                            hl_mode = "combine",
                            line_hl_group = "Substitute",
                        })
                        vim.api.nvim_buf_set_extmark(0, ns, bottom - 1, 0, {
                            hl_mode = "combine",
                            line_hl_group = "Substitute",
                        })

                        vim.defer_fn(function()
                            vim.api.nvim_command("undojoin")
                            vim.api.nvim_buf_set_text(0, top - 1, 0, top - 1, -1, {})
                            vim.api.nvim_buf_set_text(0, bottom - 1, 0, bottom - 1, -1, {})
                            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
                        end, 10)
                    else
                        return "o"
                    end
                end,
            },
        },
    },
}

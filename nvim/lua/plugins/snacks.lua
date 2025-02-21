vim.g.snacks_animate = false
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
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
                enabled = true,
                timeout = 5000,
                sort = { "added" },
            },
            quickfile = { enabled = true },
            scratch = { ft = "markdown" },
            statuscolumn = { enabled = false }, -- we set this in options.lua
            terminal = {
                win = { position = "float", wo = { winbar = "" } },
            },
            zen = {
                toggles = {
                    dim = false,
                    git_signs = true,
                    mini_diff_signs = true,
                    diagnostics = true,
                    inlay_hints = true,
                },
                show = { statusline = false, tabline = false },
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
                zen = {
                    backdrop = 1,
                    -- https://github.com/cdmill/focus.nvim/blob/main/lua/focus/config.lua#L44
                    wo = {
                        number = false,
                        relativenumber = false,
                        cursorline = false,
                        foldcolumn = "0",
                        signcolumn = "no",
                    },
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
                "<leader>zz",
                function()
                    Snacks.zen()
                end,
                desc = "Toggle Zen",
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
        config = function(_, opts)
            require("snacks").setup(opts)

            vim.api.nvim_create_autocmd("VimEnter", {
                desc = "Snacks: Enter Zen",
                callback = function()
                    Snacks.zen()
                end,
            })
        end,
    },
}

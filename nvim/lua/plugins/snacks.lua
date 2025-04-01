vim.g.snacks_animate = false
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        --- @diagnostic disable: missing-fields
        opts = {
            image = {
                enabled = true,
                doc = { inline = false },
            },
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
                notification = {
                    wo = { wrap = true },
                    focusable = false,
                },
                snacks_image = { border = "none" },
                zen = {
                    backdrop = {
                        transparent = false,
                        bg = string.format(
                            "#%06x",
                            vim.api.nvim_get_hl(0, { name = "Normal" }).bg
                        ),
                    },
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
                    Snacks.scratch({
                        icon = " ",
                        name = "Todo",
                        ft = "markdown",
                    })
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
                        require("snacks").scope.get(function (scope)
                            if scope == nil then
                                vim.api.nvim_feedkeys("o", "n", true)
                                return
                            end
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
                        end)
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

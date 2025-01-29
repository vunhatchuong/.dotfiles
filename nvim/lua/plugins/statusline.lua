return {
    {
        -- Show amount of lines in a file?
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "niilohlin/pure_branch.nvim",
        },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            vim.o.laststatus = vim.g.lualine_laststatus

            return {
                options = {
                    disabled_filetypes = {
                        statusline = { "snacks_dashboard" },
                    },
                    globalstatus = vim.o.laststatus == 3,
                    theme = Util.statusline.theme,
                    component_separators = "",
                    section_separators = "",
                },
                sections = {
                    -- stylua: ignore
                    lualine_a = {
                        { -- mode
                            -- function() return string.sub(Util.statusline.get_mode(), 1, 1) end,
                            function() return Util.statusline.get_mode() end,
                            padding = { left = 2, right = 1 },
                        },
                    },
                    lualine_b = {
                        -- { "branch", icon = "" }
                        { require("pure_branch") },
                        {
                            "diff",
                            diff_color = {
                                added = "Comment",
                                modified = "Comment",
                                removed = "Comment",
                            },
                            padding = { right = 1 },
                            -- source = function()
                            --     local gitsigns = vim.b.gitsigns_status_dict
                            --     if gitsigns then
                            --         return {
                            --             added = gitsigns.added,
                            --             modified = gitsigns.changed,
                            --             removed = gitsigns.removed,
                            --         }
                            --     end
                            -- end,
                        },
                    },
                    lualine_c = {
                        -- { "grapple", inactive = "%s" },
                        -- Mid align
                        -- "%=",
                        -- {
                        --     "filetype",
                        --     icon_only = true,
                        --     padding = { left = 1 },
                        -- },
                        -- {
                        --     "filename",
                        --     path = 1,
                        --     color = "Comment",
                        --     symbols = { modified = "", readonly = "" },
                        --     padding = { right = 1 },
                        -- },
                    },
                    -- Right
                    lualine_x = {},
                    lualine_y = {
                        {
                            "diagnostics",
                            always_visible = true,
                            sections = { "error", "warn", "info" },
                            symbols = {
                                error = "",
                                warn = "",
                                info = "",
                                hint = "",
                            },
                        },
                        {
                            function()
                                return Util.statusline.lsp_progress()
                            end,
                        },
                        {
                            Util.statusline.get_lsp_names,
                            color = "Comment",
                        },
                    },
                    lualine_z = {
                        -- {
                        --     Util.statusline.get_total_line,
                        --     cond = function()
                        --         return vim.bo.buftype == ""
                        --     end,
                        -- },
                        { "location", icon = "", padding = { left = 1 } },
                        { "progress", icon = "/" },
                        { Util.statusline.mixed_indent },
                    },
                },
                tabline = {
                    lualine_a = {
                        "%=",
                        {
                            "filetype",
                            icon_only = true,
                            padding = { left = 1 },
                        },
                        {
                            "filename",
                            path = 1,
                            color = "Comment",
                            symbols = { modified = "", readonly = "" },
                            padding = { right = 1 },
                        },
                        { "grapple", inactive = "%s" },
                    },
                },
                extensions = {
                    "lazy",
                    "nvim-dap-ui",
                    "oil",
                    "quickfix",
                    "trouble",
                    "fzf",
                    "man",
                    "mason",
                },
            }
        end,
    },
}

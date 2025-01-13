return {
    {
        -- Show amount of lines in a file?
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
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

            local icons = require("core.icons")

            vim.o.laststatus = vim.g.lualine_laststatus

            return {
                options = {
                    disabled_filetypes = {
                        statusline = { "snacks_dashboard" },
                    },
                    -- stylua: ignore
                    theme = {
                        normal = {
                            a = { fg = Util.statusline.get_hl_color("WarningMsg"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        insert = {
                            a = { fg = Util.statusline.get_hl_color("Function"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        visual = {
                            a = { fg = Util.statusline.get_hl_color("Keyword"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        replace = {
                            a = { fg = Util.statusline.get_hl_color("Boolean"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                        command = {
                            a = { fg = Util.statusline.get_hl_color("String"), bg = "bg" },
                            b = { fg = "fg", bg = "bg" },
                            c = { fg = "fg", bg = "bg" },
                        },
                    },
                    globalstatus = vim.o.laststatus == 3,
                    component_separators = "",
                    section_separators = "",
                },
                sections = {
                    -- stylua: ignore
                    lualine_a = {
                        { -- mode
                            -- function() return string.sub(Util.statusline.get_mode(), 1, 1) end,
                            function() return Util.statusline.get_mode() end,
                            padding = 2,
                        },
                    },
                    lualine_b = {
                        { "branch", icon = icons.git.Branch },
                        {
                            "diff",
                            diff_color = {
                                added = "Comment",
                                modified = "Comment",
                                removed = "Comment",
                            },
                            padding = { right = 2 },
                            source = function()
                                local gitsigns = vim.b.gitsigns_status_dict
                                if gitsigns then
                                    return {
                                        added = gitsigns.added,
                                        modified = gitsigns.changed,
                                        removed = gitsigns.removed,
                                    }
                                end
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            "grapple",
                            -- icon = "",
                            inactive = "%s",
                            -- padding = { left = 1, right = 5 },
                        },
                        -- Mid align
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
                        -- {
                        --     function()
                        --         return require("grapple").name_or_index()
                        --     end,
                        --     cond = function()
                        --         return package.loaded["grapple"]
                        --             and require("grapple").exists()
                        --     end,
                        -- },
                    },
                    -- Right
                    lualine_x = {},
                    lualine_y = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warning,
                                info = icons.diagnostics.Information,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            function()
                                return Util.statusline.lsp_progress()
                            end,
                        },
                        {
                            Util.statusline.get_lsp_names,
                            icon = icons.git.Octoface,
                            color = "Comment",
                        },
                    },
                    lualine_z = {
                        { "location", icon = "", padding = { left = 2 } },
                        { "progress", icon = "/" },
                        { Util.statusline.mixed_indent },
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

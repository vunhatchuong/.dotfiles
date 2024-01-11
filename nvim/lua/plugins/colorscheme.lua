return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavor = "mocha",
                -- transparent_background = true, -- disables setting the background color.
                integrations = {
                    treesitter = true,
                    treesitter_context = true,
                    cmp = true,
                    gitsigns = true,
                    harpoon = true,
                    illuminate = true,
                    leap = true,
                    lsp_trouble = true,
                    mason = true,
                    markdown = true,
                    indent_blankline = {
                        enabled = true,
                        scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                        colored_indent_levels = true,
                    },
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                    native_lsp = {
                        enabled = true,
                    },
                    navic = {
                        enabled = true,
                        custom_bg = "lualine",
                    },
                    rainbow_delimiters = true,
                    telescope = {
                        enabled = true,
                    },
                },
                -- Use command :hi to check out highlight groups
                custom_highlights = function(colors)
                    return {
                        IncSearch = { bg = colors.flamingo },
                    }
                end,
            })
            vim.cmd("colorscheme catppuccin")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
}

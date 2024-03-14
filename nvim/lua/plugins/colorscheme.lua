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
                    semantic_tokens = true,
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
                        scope_color = "",
                        colored_indent_levels = true,
                    },
                    mini = {
                        enabled = true,
                        indentscope_color = "pink",
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    rainbow_delimiters = true,
                    telescope = {
                        enabled = true,
                    },
                    fidget = true,
                    dap = true,
                    dap_ui = true,
                    neotest = true,
                },
                -- Use command :hi to check out highlight groups
                custom_highlights = function(colors)
                    return {
                        IncSearch = { bg = colors.flamingo },
                    }
                end,
            })
        end,
    },
    {
        "rose-pine/neovim",
        lazy = false,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
    },
    {
        "aktersnurra/no-clown-fiesta.nvim",
        lazy = false,
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
        lazy = false,
    },
    {
        "kdheepak/monochrome.nvim",
        lazy = false,
    },
}

return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
        opts = {
            layout = "float",
            schemes = {
                "catppuccin-mocha",
                "rose-pine",
                "oxocarbon",
                "no-clown-fiesta",
                "rosebones",
                "monochrome",
                "sequoia",
                "eldritch",
            },
            window = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("scheming").setup(opts)
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
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
        name = "rose-pine",
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
    },
    {
        "aktersnurra/no-clown-fiesta.nvim",
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
        },
    },
    {
        "kdheepak/monochrome.nvim",
    },
    {
        "Hiroya-W/sequoia-moonlight.nvim",
    },
    {
        "eldritch-theme/eldritch.nvim",
    },
}

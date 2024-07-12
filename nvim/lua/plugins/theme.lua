return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
        opts = {
            layout = "float",
            schemes = {
                "catppuccin-mocha",
                "rose-pine",
                "rosebones",
                "no-clown-fiesta",
                "monochrome",
                "sequoia",
                "eldritch",
                "lackluster-hack",
                "Duskfox",
                "Carbonfox",
                "moonfly",
                "oxocarbon",
                "blue-moon",
                "crimson_moonlight",
                "nordic",
                "palette",
            },
            window = {
                border = "rounded",
            },
        },
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
    { "rose-pine/neovim", name = "rose-pine" },
    { "aktersnurra/no-clown-fiesta.nvim" },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
            cmd = { "Lushify" },
        },
    },
    { "kdheepak/monochrome.nvim" },
    { "Hiroya-W/sequoia-moonlight.nvim" },
    { "eldritch-theme/eldritch.nvim" },
    { "slugbyte/lackluster.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "bluz71/vim-moonfly-colors", name = "moonfly" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "kyazdani42/blue-moon" },
    { "rockerBOO/boo-colorscheme-nvim" },
    { "AlexvZyl/nordic.nvim" },
    {
        "roobert/palette.nvim",
        config = function()
            require("palette").setup({
                caching = true,
                palettes = {
                    main = "sequoia_monochrome",
                    accent = "sequoia_monochrome",
                    state = "sequoia_monochrome",
                },

                italics = true,
                transparent_background = false,

                custom_palettes = {
                    main = {
                        sequoia_monochrome = {
                            color0 = "#0F1014", -- BG
                            color1 = "#1F1F24", -- Visual, CursorLine BG
                            color2 = "#868690", -- Cursor, Fold
                            color3 = "#626983", -- Keyword, LineNumber
                            color4 = "#626983", -- Delimiter
                            color5 = "#868690", -- Identifier
                            color6 = "#43444D", -- Comments
                            color7 = "#B6BAC8", -- Function
                            color8 = "#D3D5DE", -- String
                        },
                    },
                    accent = {
                        sequoia_monochrome = {
                            accent0 = "#B6BAC8", -- Number
                            accent1 = "#575861", -- Search, Visual text
                            accent2 = "#FFEE55", -- ??
                            accent3 = "#43444D", -- MatchParen
                            accent4 = "#B6BAC8", -- Bool, Float, Const
                            accent5 = "#50AFFF", -- ??
                            accent6 = "#FF5A8F", -- ??
                            accent7 = "#D45AFA", -- ??
                        },
                    },
                    state = {
                        sequoia_monochrome = {
                            error = "#A6002F",
                            warning = "#ea9d34",
                            hint = "#907aa9",
                            ok = "#006c42",
                            info = "#31748f",
                        },
                    },
                },
            })
        end,
    },
}

return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
        opts = {
            layout = "float",
            schemes = {
                "default",
                "rosebones",
                "eldritch",
                "lackluster-hack",
                "Duskfox",
                "blue-moon",
                "nordic",
                "sequoia-moonlight",
                "palette",
                "sequoia",
                "flow",
                "dogrun",
                "crimson_moonlight",
                "sakura",
                "darkvoid",
            },
            window = {
                border = "rounded",
            },
        },
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
            cmd = { "Lushify" },
        },
    },
    { "Hiroya-W/sequoia-moonlight.nvim" },
    { "eldritch-theme/eldritch.nvim" },
    { "slugbyte/lackluster.nvim" },
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
    {
        "0xstepit/flow.nvim",
        opts = {
            transparent = true,
            fluo_color = "pink",
            mode = "normal",
            aggressive_spell = false,
        },
    },
    { "wadackel/vim-dogrun" },
    { "anAcc22/sakura.nvim" },
    { "aliqyan-21/darkvoid.nvim" },
}

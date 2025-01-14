return {
    { -- Highlight args, defs and usages using Treesitter.
        "m-demare/hlargs.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            paint_arg_declarations = true,
            paint_arg_usages = true,
            paint_catch_blocks = {
                declarations = false,
                usages = false,
            },
            extras = {
                named_parameters = false,
                unused_args = false,
            },
            highlight = { italic = true, cterm = { italic = true } },
        },
    },
    {
        "lmantw/themify.nvim",
        lazy = false,
        opts = {
            "default",
            {
                "mcchrish/zenbones.nvim",
                before = function()
                    vim.g.bones_compat = 1
                    vim.g.lightness = "dim"
                    vim.g.darkness = "stark"
                    vim.g.solid_float_border = true
                    vim.g.colorize_diagnostic_underline_text = true
                end,
                -- whitelist = { "tokyonight-night", "tokyonight-day" },
                blacklist = { "randombones", "forestbones", "seoulbones" },
            },
            "Hiroya-W/sequoia-moonlight.nvim",
            { "slugbyte/lackluster.nvim" },
            { "tek256/simple-dark" },
            { "aktersnurra/no-clown-fiesta.nvim" },
            { "aliqyan-21/darkvoid.nvim" },
            {
                "cvigilv/patana.nvim",
                branch = "develop",
                before = function()
                    vim.g.patana_high_contrast = true
                    vim.g.patana_colored_statusline = true
                    vim.g.patana_oob_filetypes =
                        { "qf", "lazy", "mason", "help" }
                end,
            },
            { "wnkz/monoglow.nvim" },
            { "bettervim/yugen.nvim" },
            { "kyazdani42/blue-moon" },
            { "rockerBOO/boo-colorscheme-nvim" },
            { "wadackel/vim-dogrun" },
            -- { "anAcc22/sakura.nvim" }, -- Missing lush
            { "Yazeed1s/oh-lucy.nvim" },
            { "Shadorain/shadotheme" },
            { "blazkowolf/gruber-darker.nvim" },
            { "kvrohit/substrata.nvim" },
            { "mcauley-penney/ice-cave.nvim" },
            { "ronisbr/nano-theme.nvim" },
            { "ramojus/mellifluous.nvim" },
            { "dgox16/oldworld.nvim" },
            { "ficcdaf/ashen.nvim" },
            { "datsfilipe/vesper.nvim" },
            { "FrenzyExists/aquarium-vim" },
            -- { "rithikasilva/monoplus.nvim" },
            { "rithikasilva/sequoia-monochrome.nvim" },
            { "kdheepak/monochrome.nvim" },
            { "kvrohit/rasmus.nvim" },
            -- { "Wansmer/serenity.nvim" },
            -- Light Theme
            { "yorickpeterse/nvim-grey" },
            { "yorickpeterse/vim-paper" },
        },
        config = function(_, opts)
            require("themify").setup(opts)
        end,
    },
    {
        "vunhatchuong/themify-extras.nvim",
        dependencies = { "lmantw/themify.nvim" },
        lazy = false,
        opts = {
            randomize = {
                enable = true,
                daily = true,
            },
            daylight = {
                enable = true,
            },
        },
    },
}

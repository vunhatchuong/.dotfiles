return {
    { -- Highlight args, defs and usages using Treesitter.
        "m-demare/hlargs.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
            "macro",
            {
                "mcchrish/zenbones.nvim",
                before = function()
                    vim.g.bones_compat = 1
                    vim.g.lightness = "dim"
                    vim.g.darkness = "stark"
                    vim.g.solid_float_border = true
                    vim.g.colorize_diagnostic_underline_text = true
                end,
                blacklist = {
                    "randombones",
                    "zenbones",
                    "forestbones",
                    "seoulbones",
                    "nordbones",
                    "zenburned",
                },
            },
            "Hiroya-W/sequoia-moonlight.nvim",
            { "rithikasilva/sequoia-monochrome.nvim" },
            {
                "slugbyte/lackluster.nvim",
                blacklist = { "lackluster" },
            },
            {
                "tek256/simple-dark",
                blacklist = { "simple-dark-transparent" },
            },
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
            {
                "wnkz/monoglow.nvim",
                blacklist = { "monoglow" },
            },
            { "bettervim/yugen.nvim" },
            { "kyazdani42/blue-moon" },
            { "rockerBOO/boo-colorscheme-nvim" },
            { "wadackel/vim-dogrun" },
            -- { "anAcc22/sakura.nvim" }, -- Missing lush
            { "Yazeed1s/oh-lucy.nvim" },
            {
                "Shadorain/shadotheme",
                blacklist = { "shado-legacy" },
            },
            { "blazkowolf/gruber-darker.nvim" },
            { "kvrohit/substrata.nvim" },
            { "mcauley-penney/ice-cave.nvim" },
            { "ramojus/mellifluous.nvim" },
            { "dgox16/oldworld.nvim" },
            { "ficcdaf/ashen.nvim" },
            { "drewxs/ash.nvim" },
            { "datsfilipe/vesper.nvim" },
            -- { "rithikasilva/monoplus.nvim" },
            { "kdheepak/monochrome.nvim" },
            { "kvrohit/rasmus.nvim" },
            { "masar3141/mono-jade" },
            { "p00f/alabaster.nvim" },
            { "gmr458/cold.nvim" },
            { "water-sucks/darkrose.nvim" },
            -- { "metalelf0/jellybeans-nvim" }, -- Required lush.nvim
            {
                "idr4n/github-monochrome.nvim",
                blacklist = { "github-monochrome" },
            },
            { "oonamo/ef-themes.nvim" },
            -- { "Wansmer/serenity.nvim" },
            { "rjshkhr/shadow.nvim" },
            { "Skardyy/makurai-nvim" },
            { "vunhatchuong/gleam-theme.nvim" },
            -- Light Theme
            -- { "yorickpeterse/nvim-grey" },
            { "yorickpeterse/vim-paper" },
        },
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
                day_start = 8,
                night_start = 11,
            },
        },
    },
}

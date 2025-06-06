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
            "rithikasilva/sequoia-monochrome.nvim",
            "forest-nvim/sequoia.nvim",
            "webhooked/kanso.nvim",
            {
                "slugbyte/lackluster.nvim",
                blacklist = { "lackluster" },
            },
            {
                "tek256/simple-dark",
                blacklist = { "simple-dark-transparent" },
            },
            "aktersnurra/no-clown-fiesta.nvim",
            "aliqyan-21/darkvoid.nvim",
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
            "bettervim/yugen.nvim",
            "kyazdani42/blue-moon",
            "rockerBOO/boo-colorscheme-nvim",
            "wadackel/vim-dogrun",
            -- "anAcc22/sakura.nvim", -- Missing lush
            "Yazeed1s/oh-lucy.nvim",
            { "Shadorain/shadotheme", blacklist = { "shado-legacy" } },
            "blazkowolf/gruber-darker.nvim",
            "mcauley-penney/ice-cave.nvim",
            "cocopon/iceberg.vim",
            "ramojus/mellifluous.nvim",
            "dgox16/oldworld.nvim",
            "ficcdaf/ashen.nvim",
            "drewxs/ash.nvim",
            "datsfilipe/vesper.nvim",
            "sponkurtus2/angelic.nvim",
            -- "rithikasilva/monoplus.nvim",
            "kdheepak/monochrome.nvim",
            "kvrohit/substrata.nvim",
            "kvrohit/rasmus.nvim",
            "masar3141/mono-jade",
            "p00f/alabaster.nvim",
            "gmr458/cold.nvim",
            "water-sucks/darkrose.nvim",
            -- "ilof2/posterpole.nvim",
            "armannikoyan/rusty",
            -- "metalelf0/jellybeans-nvim", -- Required lush.nvim
            "wtfox/jellybeans.nvim",
            {
                "idr4n/github-monochrome.nvim",
                blacklist = { "github-monochrome" },
            },
            {
                "oonamo/ef-themes.nvim",
                blacklist = {
                    "ef-theme",
                    "ef-frost",
                    "ef-deuteranopia-light",
                    "ef-duo-light",
                },
            },
            -- "Wansmer/serenity.nvim",
            "rjshkhr/shadow.nvim",
            "Skardyy/makurai-nvim",
            "wheat-thin-wiens/rei.nvim",
            -- "vunhatchuong/gleam-theme.nvim",
            "vague2k/vague.nvim",
            "embark-theme/vim",
            "ptdewey/darkearth-nvim",
            "monaqa/colorimetry.nvim",
            "matsuuu/pinkmare",
            "4513ECHO/vim-colors-hatsunemiku",
            "srt0/everblush.nvim",
            "comfysage/cuddlefish.nvim",
            "cdmill/neomodern.nvim",
            "metalelf0/black-metal-theme-neovim",
            "titembaatar/sarnai.nvim",
            -- Light Theme --
            -- "yorickpeterse/nvim-grey",
            "yorickpeterse/vim-paper",
            "alexxGmZ/e-ink.nvim",
            -- "rxils/triplebaka.nvim",
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

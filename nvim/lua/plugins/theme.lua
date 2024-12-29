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
        config = {
            "default",
            {
                "mcchrish/zenbones.nvim",
                before = function()
                    vim.g.bones_compat = 1
                end,
                -- whitelist = { "tokyonight-night", "tokyonight-day" },
                blacklist = { "randombones" },
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
            { "eldritch-theme/eldritch.nvim" },
            { "wadackel/vim-dogrun" },
            -- { "anAcc22/sakura.nvim" }, -- Missing lush
            { "blazkowolf/gruber-darker.nvim" },
            { "kvrohit/substrata.nvim" },
            { "mcauley-penney/ice-cave.nvim" },
            {
                "0xstepit/flow.nvim",
                before = function()
                    local ok, flow = pcall(require, "flow")
                    if ok then
                        flow.setup({
                            theme = {
                                style = "dark",
                                contrast = "high", -- "default" | "high"
                                transparent = false, -- true | false
                            },
                            colors = {
                                mode = "light",
                                fluo = "pink", -- "pink" | "cyan"
                            },
                            ui = {
                                borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
                                aggressive_spell = false, -- true | false
                            },
                        })
                    end
                end,
            },
            { "ramojus/mellifluous.nvim", branch = "v1" },
            { "dgox16/oldworld.nvim" },
        },
    },
}

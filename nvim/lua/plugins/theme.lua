return {
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
            { "kyazdani42/blue-moon" },
            { "rockerBOO/boo-colorscheme-nvim" },
            { "AlexvZyl/nordic.nvim" },
            { "eldritch-theme/eldritch.nvim" },
            { "wadackel/vim-dogrun" },
            { "anAcc22/sakura.nvim" },
            { "aliqyan-21/darkvoid.nvim" },
            { "blazkowolf/gruber-darker.nvim" },
            { "tek256/simple-dark" },
            { "kvrohit/substrata.nvim" },
            { "mcauley-penney/ice-cave.nvim" },
            { "aktersnurra/no-clown-fiesta.nvim" },
            {
                "0xstepit/flow.nvim",
                before = function()
                    local ok, flow = pcall(require, "flow")
                    if ok then
                        flow.setup({
                            theme = {
                                style = "dark", --  "dark" | "light"
                                contrast = "default", -- "default" | "high"
                                transparent = false, -- true | false
                            },
                            colors = {
                                mode = "default", -- "default" | "dark" | "light"
                                fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
                            },
                            ui = {
                                borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
                                aggressive_spell = false, -- true | false
                            },
                        })
                    end
                end,
            },

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
            { "ramojus/mellifluous.nvim", branch = "v1" },
            { "dgox16/oldworld.nvim" },
            { "wnkz/monoglow.nvim" },
        },
    },
}

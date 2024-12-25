return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
        init = function()
            -- Manually triggers ColorScheme event to run related autocmds
            -- Since scheming.nvim doesn't run vim.cmd("colorscheme theme")
            vim.cmd("doautocmd ColorScheme")
        end,
        opts = {
            layout = "float",
            schemes = {
                "default",
                "gruber-darker",
                "lackluster-hack",
                "lackluster-mint",
                "blue-moon",
                "nordic",
                "sequoia",
                "eldritch",
                "flow",
                "dogrun",
                "rosebones",
                "crimson_moonlight",
                "sakura",
                "darkvoid",
                "simple-dark",
            },
            window = { border = vim.g.border_style },
        },
    },
    {
        "mcchrish/zenbones.nvim",
        init = function()
            vim.g.bones_compat = 1
        end,
    },
    { "Hiroya-W/sequoia-moonlight.nvim" },
    { "slugbyte/lackluster.nvim" },
    { "kyazdani42/blue-moon" },
    { "rockerBOO/boo-colorscheme-nvim" },
    { "AlexvZyl/nordic.nvim" },
    { "eldritch-theme/eldritch.nvim" },
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
    { "blazkowolf/gruber-darker.nvim" },
    { "tek256/simple-dark" },
    { "kvrohit/substrata.nvim" },
    { "mcauley-penney/ice-cave.nvim" },
    { "aktersnurra/no-clown-fiesta.nvim" },
    { "ramojus/mellifluous.nvim", branch = "v1" },
    {
        "cvigilv/patana.nvim",
        branch = "develop",
        init = function()
            vim.g.patana_high_contrast = true
            vim.g.patana_colored_statusline = true
            vim.g.patana_oob_filetypes = { "qf", "lazy", "mason", "help" }
        end,
    },
    { "dgox16/oldworld.nvim" },
}

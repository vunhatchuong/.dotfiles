return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
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
            window = { border = vim.g.bordor_style },
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
}

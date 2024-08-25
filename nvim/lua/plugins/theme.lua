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
                "simple-dark"
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
}

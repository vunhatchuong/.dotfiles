return {
    {
        "wllfaria/scheming.nvim",
        lazy = false,
        opts = {
            layout = "float",
            schemes = {
                "catppuccin-mocha",
                "rose-pine",
                "oxocarbon",
                "no-clown-fiesta",
                "rosebones",
                "monochrome",
                "sequoia",
                "eldritch"
            },
            window = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("scheming").setup(opts)
        end,
    },
}

return {
    "j-hui/fidget.nvim",
    cmd = "Fidget",
    opts = {
        integration = {
            ["nvim-tree"] = {
                enable = true,
            },
        },
        -- Catppuccin
        notification = {
            window = {
                winblend = 0,
            },
        },
    },
}

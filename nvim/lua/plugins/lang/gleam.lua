return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "gleam" } },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gleam = {},
            },
        },
    },
}

return {
    Util.tool_installer.ensure_installed({
        treesitter = { "gleam" },
        mason = {},
    }),

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gleam = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                gleam = { "gleam" },
            },
        },
    },
}

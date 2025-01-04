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
}

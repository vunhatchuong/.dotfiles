return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "zig" } },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- https://github.com/zigtools/zls/blob/master/src/Config.zig
                zls = {
                    settings = {
                        zls = {
                            warn_style = true,
                        },
                    },
                },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "zls" } },
    },
}

return {
    Util.tool_installer.ensure_installed({
        treesitter = { "zig" },
        mason = { "zls" },
    }),
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
}

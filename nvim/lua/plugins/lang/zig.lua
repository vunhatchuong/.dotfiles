return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "zig",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- https://github.com/zigtools/zls/blob/master/src/Config.zig
                zls = {
                    on_attach = function()
                        vim.keymap.set({ "n", "x", "o" }, "<C-/>", "gcc", { remap = true })
                    end,
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
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "zls",
                -- Linter
                -- Formatter
                -- Code actions
                -- Extras
            })
        end,
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "go",
                "gomod",
                "gowork",
                "gosum",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    keys = {},
                    settings = {
                        gopls = {
                            gofumpt = true,
                            directoryFilters = {
                                "-.git",
                                "-.vscode",
                                "-.idea",
                                "-.vscode-test",
                                "-node_modules",
                            },
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
                "gopls",
                "gofumpt",
                "golangci-lint",
                "goimports-reviser",
                "golines",
                "gotests",
                "gomodifytags",
                "impl",
                "templ",
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.formatting.gofumpt,
                nls.builtins.diagnostics.golangci_lint,
                nls.builtins.formatting.goimports_reviser,
                nls.builtins.formatting.golines,
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
            })
        end,
    },
}

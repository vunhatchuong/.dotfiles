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
                "golangci-lint-langserver",
                -- Linter
                -- Formatter
                "gofumpt",
                "goimports",
                "goimports-reviser",
                "golines",
                "gotests",
                "gomodifytags",
                -- Code actions
                "impl",
                "templ",
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            local gotests = require("plugins.lang.gotests")
            local iferr = require("plugins.lang.iferr")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
                nls.builtins.diagnostics.golangci_lint.with({
                    args = {
                        "run",
                        "-E",
                        "gofumpt",
                        "--out-format=json",
                        "$FILENAME",
                    },
                }),
                gotests,
                iferr,
            })
        end,
    },
    -- {
    --     "mfussenegger/nvim-lint",
    --     optional = true,
    --     opts = {
    --         linters_by_ft = {
    --             go = { "golangcilint" },
    --         },
    --     },
    -- },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                go = {
                    "goimports",
                    "goimports_reviser",
                    "golines",
                    "templ",
                },
            },
            formatters = {
                golines = {
                    prepend_args = { "--base-formatter=gofumpt" },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, { "delve" })
                end,
            },
            {
                "leoluz/nvim-dap-go",
                config = true,
            },
        },
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "go",
                "gomod",
                "gowork",
                "gosum",
                "templ",
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
                "golangci-lint",
                -- Formatter
                "gofumpt",
                "goimports",
                "goimports-reviser",
                "golines",
                -- Code actions
                "impl",
                "gotests",
                "gomodifytags",
                "iferr",
                -- Extras
                "templ",
            })
            vim.filetype.add({ extension = { templ = "templ" } })
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
            -- https://golangci-lint.run/usage/linters/
            local linters = {
                "gofumpt",
                "goimports",
                "goprintffuncname",
                "gosec",
                "misspell",
                "nakedret",
                "exhaustive",
                "exhaustruct",
                "prealloc",
                "gocritic",
                "bodyclose",
                "testifylint",
                "unconvert",
                "wsl",
                "gocheckcompilerdirectives",
            }
            local function addEFlag()
                local args = {}
                for _, linter in ipairs(linters) do
                    table.insert(args, "-E")
                    table.insert(args, linter)
                end
                -- Because unpack only unpack 1st arg if not last arg
                table.insert(args, "--out-format=json")
                table.insert(args, "$FILENAME")
                return args
            end
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.diagnostics.golangci_lint.with({
                    args = {
                        "run",
                        unpack(addEFlag()),
                    },
                }),
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
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

return {
    Util.tool_installer.ensure_installed({
        treesitter = { "go", "gomod", "gowork", "gosum", "templ" },
        mason = {
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
        },
    }),
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {
                    keys = {},
                    settings = {
                        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                nilness = true,
                                useany = true,
                            },
                            directoryFilters = {
                                "-.git",
                                "-.vscode",
                                "-.idea",
                                "-.vscode-test",
                                "-node_modules",
                            },
                            usePlaceholders = true,
                            staticcheck = true,
                            semanticTokens = false, -- Bugged and go.nvim said treesiter is better
                        },
                    },
                },
            },
            attach_server = {
                gopls = function(client)
                    -- workaround for gopls not supporting semanticTokensProvider
                    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
                    if client.server_capabilities.semanticTokensProvider then
                        local semantic =
                            client.config.capabilities.textDocument.semanticTokens

                        if semantic then
                            client.server_capabilities.semanticTokensProvider =
                                {
                                    full = true,
                                    legend = {
                                        tokenTypes = semantic.tokenTypes,
                                        tokenModifiers = semantic.tokenModifiers,
                                    },
                                    range = true,
                                }
                        end
                    end
                end,
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = function()
            vim.filetype.add({ extension = { templ = "templ" } })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        ft = { "go", "gomod", "gowork", "gosum", "templ" },
        dependencies = { "williamboman/mason.nvim" },
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
        "maxandron/goplements.nvim",
        ft = "go",
        opts = {
            display_package = true,
        },
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = { ensure_installed = { "delve" } },
            },
            {
                "leoluz/nvim-dap-go",
                opts = {},
            },
        },
    },
}

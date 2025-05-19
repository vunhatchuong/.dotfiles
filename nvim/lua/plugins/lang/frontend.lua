return {
    Util.tool_installer.ensure_installed({
        treesitter = {
            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
        },
        mason = {
            "vtsls",
            "tailwindcss",
            -- Linter
            "biome",
            -- Formatter
            -- Code actions
            -- Extras
        },
    }),
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                tsserver = { enabled = false },
                ts_ls = { enabled = false },
                vtsls = {
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                maxInlayHintLength = 30,
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = "always" },
                            suggest = { completeFunctionCalls = true },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterTypes = { enabled = true },
                                -- parameterNames = { enabled = "all" },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                            format = {
                                baseIndentSize = 2,
                                indentSize = 2,
                                tabSize = 2,
                                convertTabsToSpaces = true,
                            },
                        },
                        javascript = {
                            format = {
                                baseIndentSize = 2,
                                indentSize = 2,
                                tabSize = 2,
                                convertTabsToSpaces = true,
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        dependencies = { "mason-org/mason.nvim" },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = opts.sources or {}
            table.insert(opts.sources, nls.builtins.formatting.biome)
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                html = { "prettier" },
                css = { "biome-check" },
                javascript = { "biome-check" },
                javascriptreact = { "biome-check" },
                typescript = { "biome-check" },
                typescriptreact = { "biome-check" },
            },
            formatters = {
                ["biome-check"] = {
                    append_args = { "--indent-style=space", "--indent-width=2" },
                },
            },
        },
    },
}

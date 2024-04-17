return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "python" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
                ruff_lsp = {
                    keys = {},
                },
            },
        },
        setup = {
            ruff_lsp = function()
                local lsp = require("lspconfig")
                lsp.on_attach(function(client, _)
                    if client.name == "ruff_lsp" then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end)
            end,
        },
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "pyright",
                "ruff-lsp", -- Mainly for code actions
                -- Linter
                "mypy",
                "ruff", -- Also Formatter
                -- Formatter
                -- Code actions
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                python = {
                    "mypy",
                    "ruff",
                },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = {
                    "ruff_fix", -- Fix lint errors
                    "ruff_format", -- Formatter
                },
            },
        },
    },
}

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
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "pyright",
                -- Linter
                "flake8",
                "mypy",
                -- Formatter
                "autopep8",
                "isort",
                -- Code actions
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = {
            linters_by_ft = {
                python = { "flake8", "mypy" },
            },
        },
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                python = {
                    "autopep8",
                    "isort",
                },
            },
        },
    },
}

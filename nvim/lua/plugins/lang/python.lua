return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "python", "toml" } },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ruff = {
                    enabled = true,
                    cmd_env = { RUFF_TRACE = "messages" },
                    init_options = {
                        settings = {
                            logLevel = "error",
                        },
                    },
                },
                basedpyright = {
                    enabled = true,
                },
            },
            attach_server = {
                ruff = function(client, event)
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end,
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "basedpyright",
                -- Linter
                "mypy",
                "ruff", -- Also Formatter
                -- Formatter
                -- Code actions
            },
        },
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
                    "ruff_organize_imports",
                },
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        optional = true,
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "python", "toml" })
        end,
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
            setup = {
                ruff = function()
                    vim.api.nvim_create_autocmd("LspAttach", {
                        group = vim.api.nvim_create_augroup(
                            "lsp_attach_disable_ruff_hover",
                            { clear = true }
                        ),
                        callback = function(args)
                            local client =
                                vim.lsp.get_client_by_id(args.data.client_id)
                            if client and client.name == "ruff" then
                                -- Disable hover in favor of Pyright
                                client.server_capabilities.hoverProvider = false
                            end
                        end,
                    })
                end,
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, {
                "basedpyright",
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

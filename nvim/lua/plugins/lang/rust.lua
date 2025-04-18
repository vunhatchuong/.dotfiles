return {
    Util.tool_installer.ensure_installed({
        treesitter = { "rust", "ron" },
    }),
    { -- LSP for Cargo.toml
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = { enabled = true },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
        ft = "rust",
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>cR", function()
                        vim.cmd.RustLsp("codeAction")
                    end, {
                        desc = "Code Action",
                        buffer = bufnr,
                    })
                    vim.keymap.set("n", "<leader>dr", function()
                        vim.cmd.RustLsp("debuggables")
                    end, {
                        desc = "Rust Debuggables",
                        buffer = bufnr,
                    })
                end,
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                            buildScripts = { enable = true },
                        },
                        -- Add clippy lints for Rust if using rust-analyzer
                        checkOnSave = true,
                        -- Enable diagnostics if using rust-analyzer
                        diagnostics = { enable = true },
                        procMacro = { enable = true },
                        inlayHints = {
                            lifetimeElisionHints = {
                                enable = true,
                                useParameterNames = true,
                            },
                        },
                        files = {
                            excludeDirs = {
                                ".direnv",
                                ".git",
                                ".github",
                                ".gitlab",
                                "bin",
                                "node_modules",
                                "target",
                                "venv",
                                ".venv",
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend(
                "keep",
                vim.g.rustaceanvim or {},
                opts or {}
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                rust = { "rustfmt" },
            },
        },
    },
}

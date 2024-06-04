return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(
                    opts.ensure_installed,
                    { "markdown", "markdown_inline" }
                )
            end
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(
                opts.ensure_installed,
                { "markdownlint-cli2", "marksman" }
            )
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                yamlls = {
                    -- Have to add this for yamlls to understand that we support line folding
                    capabilities = {
                        textDocument = {
                            foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            },
                        },
                    },
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            "force",
                            new_config.settings.yaml.schemas or {},
                            require("schemastore").yaml.schemas()
                        )
                    end,
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = {
                                enable = true,
                            },
                            validate = true,
                            schemaStore = {
                                -- Must disable built-in schemaStore support to use
                                -- schemas from SchemaStore.nvim plugin
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                        },
                    },
                },
            },
            setup = {},
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewToggle",
        },
        keys = {
            {
                "<leader>md",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Find recently opened Files",
            },
        },
        build = function()
            local install_path = vim.fn.stdpath("data")
                .. "/lazy/markdown-preview.nvim/app"

            if vim.fn.executable("node") == 0 then
                print("Node not found")
                vim.fn["mkdp#util#install"]()
            else
                vim.cmd(
                    "silent !cd "
                        .. install_path
                        .. " && npm install && git restore ."
                )
            end
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "MeanderingProgrammer/markdown.nvim",
        name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        opts = {},
    },
}

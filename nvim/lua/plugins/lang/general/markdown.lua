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
                ":MarkdownPreviewToggle<CR>",
                desc = "Find recently opened Files",
            },
        },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_close = 0
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown", "norg", "rmd", "org" },
        opts = {
            heading = {
                sign = false,
                icons = {},
            },
            code = {
                sign = false,
                width = "block",
            },
        },
    },
    {
        "ChuufMaster/markdown-toc",
        cmd = { "GenerateTOC", "DeleteTOC" },
        opts = {
            ask_for_heading_level = false,
        },
    },
    {
        "Kicamon/markdown-table-mode.nvim",
        ft = { "markdown", "norg", "rmd", "org" },
        opts = {},
    },
    {
        "jmbuhr/otter.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
        config = function(_, opts)
            require("otter").setup(opts)

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "*.md", "*.ipynb" },
                callback = function()
                    require("otter").activate()
                end,
            })
        end,
    },
    {
        "gaoDean/autolist.nvim",
        ft = { "markdown", "text", "tex", "plaintex", "norg" },
        config = function()
            require("autolist").setup()

            vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
            vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
            vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
            vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
            vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
            vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
            vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

            -- functions to recalculate list on edit
            vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
            vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
            vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
            vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
        end,
    },
}

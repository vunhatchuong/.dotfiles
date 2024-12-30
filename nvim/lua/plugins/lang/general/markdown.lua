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
                "<CMD>MarkdownPreviewToggle<CR>",
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
                position = "inline",
                width = "block",
                left_margin = 0.5,
                left_pad = 0.2,
                right_pad = 0.2,
                icons = {},
            },
            code = {
                sign = false,
                width = "block",
                border = "none",
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
        "gaoDean/autolist.nvim",
        ft = { "markdown", "text", "tex", "plaintex", "norg" },
        -- stylua: ignore
        keys = {
            { mode = { "i" }, "<TAB>", "<CMD>AutolistTab<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { mode = { "i" }, "<S-TAB>", "<CMD>AutolistShiftTab<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { mode = { "i" }, "<CR>", "<CR><CMD>AutolistNewBullet<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { "o", "o<CMD>AutolistNewBullet<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { "O", "O<CMD>AutolistNewBulletBefore<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { "<CR>", "<CMD>AutolistToggleCheckbox<CR><CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            -- functions to recalculate list on edit
            { "<C-R>", "<CMD>AutolistRecalculate<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { ">>", ">><CMD>AutolistRecalculate<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { "<<", "<<<CMD>AutolistRecalculate<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { "dd", "dd<CMD>AutolistRecalculate<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
            { mode = { "v" }, "d", "d<CMD>AutolistRecalculate<CR>", ft = { "markdown", "text", "tex", "plaintex", "norg" } },
        },
        opts = {},
    },
}

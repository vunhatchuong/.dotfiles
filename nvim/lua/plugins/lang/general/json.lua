return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(
                    opts.ensure_installed,
                    { "json", "json5", "jsonc" }
                )
            end
        end,
    },
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {
                    -- lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas
                            or {}
                        vim.list_extend(
                            new_config.settings.json.schemas,
                            require("schemastore").json.schemas()
                        )
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
            },
        },
    },
    {
        "Myzel394/jsonfly.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>j",
                ":Telescope jsonfly<CR>",
                desc = "Open json(fly)",
                ft = { "json", "xml", "yaml" },
            },
        },
        opts = {
            extensions = {
                jsonfly = {},
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("jsonfly")
        end,
    },
}

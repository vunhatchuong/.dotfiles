return {
    Util.tool_installer.ensure_installed({
        treesitter = { "json", "json5", "jsonc" },
        mason = {},
    }),
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
                "<leader>jf",
                "<CMD>Telescope jsonfly<CR>",
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

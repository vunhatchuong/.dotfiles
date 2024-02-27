-- https://github.com/stevearc/conform.nvim/tree/master?tab=readme-ov-file#formatters
return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({
                        lsp_fallback = true,
                    })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            -- log_level = vim.log.levels.DEBUG,
            format = {
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
            },
            formatters_by_ft = {
                -- Conform will run multiple formatters sequentially.
                -- Use a sub-list to run only the first available formatter
                -- Use the "*" filetype to run formatters on all filetypes.
                ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                -- ["_"] = { "trim_whitespace" },
                lua = { "stylua" },
                sh = { "shfmt" },
                html = { "prettier" },
                css = { "prettier" },
                javascript = { "prettier" },
                json = { "prettier" },
                markdown = { "markdownlint-cli2" },
                yaml = { "prettier" },
                toml = { "taplo" },
                sql = { "sqlfluff" },
            },
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces" },
                },
                prettier = {
                    prepend_args = { "--tab-width", "4" },
                },
            },
        },
    },
}

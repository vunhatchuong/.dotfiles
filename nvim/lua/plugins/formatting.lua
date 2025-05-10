-- https://github.com/stevearc/conform.nvim/tree/master?tab=readme-ov-file#formatters
return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({})
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        init = function()
            vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        opts = {
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                -- Conform will run multiple formatters sequentially.
                -- Use a sub-list to run only the first available formatter
                -- Use the "*" filetype to run formatters on all filetypes.
                -- ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                -- ["_"] = { "trim_whitespace" },
                lua = { "stylua" },
                sh = { "shfmt" },
                toml = { "taplo" },
                sql = { "sqlfluff" },
            },
            formatters = {
                -- Doesn't work
                -- injected = { options = { ignore_errors = true } },
                stylua = {
                    prepend_args = { "--indent-type", "Spaces" },
                },
                prettier = {
                    -- prepend_args = { "--tab-width", "4" },
                },
            },
        },
    },
}

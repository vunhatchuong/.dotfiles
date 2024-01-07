return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    lazy = true,
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>ff",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        formatters_by_ft = {
            -- Conform will run multiple formatters sequentially
            lua = { "stylua" },
            go = { "goimports", "gofmt" },
            python = { "isort", "black" },
            javascript = { { "prettierd", "prettier" } },
            ["_"] = { "trim_whitespace" },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

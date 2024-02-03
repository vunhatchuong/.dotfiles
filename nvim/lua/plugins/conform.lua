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
            go = {
                "goimports_reviser",
                "gofumpt",
                "golines",
                "gomodifytags",
                "gotests",
            },
            python = { "isort", "black" },
            javascript = { { "prettierd", "prettier" } },
            html = { "prettier" },
            css = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            toml = { "taplo" },
            markdown = { "markdownlint-cli2" },
            ["_"] = { "trim_whitespace" },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
        -- Override prettier's default indent type
        require("conform").formatters.prettier = {
            prepend_args = { "--tab-width", "4" },
        }
    end
}

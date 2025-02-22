-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
return {
    {
        "nvimtools/none-ls.nvim",
        -- Needs none-ls for spell checking lint/format
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        cmd = { "NullLsInfo" },
        dependencies = { "mason.nvim", "nvim-lua/plenary.nvim" },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.root_dir = opts.root_dir
                or require("null-ls.utils").root_pattern(
                    ".null-ls-root",
                    ".neoconf.json",
                    "Makefile",
                    ".git"
                )
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.completion.spell,
                -- Markdown
                nls.builtins.diagnostics.proselint,
                nls.builtins.diagnostics.markdownlint_cli2,
                nls.builtins.code_actions.proselint,
            })
            opts.notify_format = ""
        end,
    },
}

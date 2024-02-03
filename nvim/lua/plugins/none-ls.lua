return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
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
                nls.builtins.formatting.stylua,
                nls.builtins.formatting.shfmt,
                nls.builtins.completion.spell,
            })
            opts.notify_format = ""
        end,
    },
}

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
return {
    {
        "nvimtools/none-ls.nvim",
        lazy = true,
        keys = {
            {
                "<leader>ca",
                vim.lsp.buf.code_action,
                mode = { "n", "v" },
                desc = "[C]ode [A]ction",
            },
        },
        cmd = {"NullLsInfo"},
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
            })
            opts.notify_format = ""
        end,
    },
}

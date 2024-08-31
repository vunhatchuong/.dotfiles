return {
    {
        "ej-shafran/compile-mode.nvim",
        cmd = { "Compile", "Recompile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ox", ":Compile<CR>", desc = "Compile" },
            {
                "<leader>or",
                function()
                    vim.cmd("Recompile")
                    vim.cmd("wincmd k")
                end,
                desc = "Recompile",
            },
        },
        config = function()
            vim.g.compile_mode = {
                default_command = "",
                time_format = "%H:%M:%S",
                recompile_no_fail = true,
            }
        end,
    },
    {
        "vunhatchuong/compile-mode-test.nvim",
        dependencies = "ej-shafran/compile-mode.nvim",
        keys = {
            {
                "<leader>tl",
                ":CompileTestLine<CR>",
                desc = "[T]est Run [L]line",
            },
            {
                "<leader>tf",
                ":CompileTestFile<CR>",
                desc = "[T]est Run [F]ile",
            },
            {
                "<leader>td",
                ":CompileTestDir<CR>",
                desc = "[T]est Run [D]ir",
            },
            {
                "<leader>ta",
                ":CompileTestAll<CR>",
                desc = "[T]est Run [A]ll",
            },
        },
        config = function()
            require("compile-mode-test").setup({
                adapters = {
                    require("compile-mode-test.adapters.zig"),
                },
            })
        end,
    },
}

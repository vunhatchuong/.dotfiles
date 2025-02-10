return {
    {
        "ej-shafran/compile-mode.nvim",
        cmd = { "Compile", "Recompile" },
        dependencies = { "nvim-lua/plenary.nvim", "m00qek/baleia.nvim" },
        keys = {
            { "<leader>cc", "<CMD>Compile<CR>", desc = "Compile" },
            {
                "<leader>cr",
                function()
                    vim.cmd("Recompile")
                    vim.cmd("wincmd k")
                end,
                desc = "Recompile",
            },
        },
        config = function()
            vim.g.compile_mode = {
                environment = {
                    FORCE_COLOR = "1",
                },
                baleia_setup = true,

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
                "<CMD>CompileTestLine<CR>",
                desc = "[T]est Run [L]line",
            },
            {
                "<leader>tf",
                "<CMD>CompileTestFile<CR>",
                desc = "[T]est Run [F]ile",
            },
            {
                "<leader>td",
                "<CMD>CompileTestDir<CR>",
                desc = "[T]est Run [D]ir",
            },
            {
                "<leader>ta",
                "<CMD>CompileTestAll<CR>",
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
    {
        "dchae/canter.nvim",
        keys = {
            {
                "<leader><CR><CR>",
                "<CMD>CanterRun<CR>",
                desc = "Canter Run",
            },
        },
        opts = {
            runners = {
                ["py"] = "python",
            },
        },
    },
    {
        "msaher/bufix.nvim",
        event = "TermOpen",
        opts = {},
        config = function(_, opts)
            local bufix = require("bufix")
            bufix.setup(opts)

            local group =
                vim.api.nvim_create_augroup("BufixTerm", { clear = true })
            vim.api.nvim_create_autocmd("TermOpen", {
                group = group,
                callback = function(event)
                    require("bufix.api").register_buf(event.buf)
                end,
            })
        end,
    },
}

return {
    {
        "echasnovski/mini.surround",
        keys = {
            { "sa", desc = "Add surround" },
            { "sd", desc = "Delete surround" },
            { "sr", desc = "Replace surrounding" },
        },
        opts = {
            search_method = "cover_or_next",
            mappings = {
                find = "", -- Find surrounding (to the right)
                find_left = "", -- Find surrounding (to the left)
                highlight = "", -- Highlight surrounding
                update_n_lines = "", -- Update `n_lines`
            },
        },
    },
    { --[[ Upper: u, Lower: l, Snake: s, Dash: d, Const: n, Camel: c, Pascal: p
           Usage: ga{u} to change cursor word to upper
           gao to turn into motion mode. Ex: gaouw means change a word to upper ]]
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            { "ga", desc = "Change word case" },
            {
                "ga.",
                "<CMD>TextCaseOpenTelescope<CR>",
                mode = { "n", "x" },
                desc = "Change word case",
            },
        },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
    },
    {
        "chrisgrieser/nvim-chainsaw",
        cmd = "ChainSaw",
        -- stylua: ignore
        keys = {
            { "<leader>ll", function() require("chainsaw").variableLog() end, mode = { "n", "x" }, desc = "󰐪 Var" },
            { "<leader>lo", function() require("chainsaw").objectLog() end, mode = { "n", "x" }, desc = "󰐪 Object" },
            { "<leader>la", function() require("chainsaw").assertLog() end, mode = { "n", "x" }, desc = "󰐪 Assert" },
            { "<leader>lt", function() require("chainsaw").typeLog() end, mode = { "n", "x" }, desc = "󰐪 Type" },
            { "<leader>lm", function() require("chainsaw").messageLog() end, desc = "󰐪 Message" },
            { "<leader>l1", function() require("chainsaw").timeLog() end, desc = "󰐪 Time" },
            { "<leader>ld", function() require("chainsaw").debugLog() end, desc = "󰐪 Debugger" },
            { "<leader>ls", function() require("chainsaw").stacktraceLog() end, desc = "󰐪 Stacktrace" },
            { "<leader>lk", function() require("chainsaw").clearLog() end, desc = "󰐪 Clear" },

            { "<leader>lr", function() require("chainsaw").removeLogs() end, desc = "󰐪 󰅗 Remove logs" },
        },
        opts = {
            marker = ".>",
            logHighlightGroup = false,
            logStatements = {
                variableLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: {}", .{{{var}}});',
                },
                objectLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: {}", .{{{var}}});',
                },
                assertLog = {
                    zig = 'std.debug.assert({{var}}, "{{marker}} {{var}}");',
                },
                typeLog = {
                    zig = 'std.debug.print("{{marker}} {{var}}: type is {}", .{@TypeOf({{var}})});',
                },
                messageLog = {
                    zig = 'std.debug.print("{{marker}} ", .{});',
                },
                stacktraceLog = {
                    zig = "std.debug.dumpCurrentStackTrace(null);",
                },
                timeLogStart = {
                    zig = "const timelogStart{{index}} = std.time.Timer.start(); // {{marker}}",
                },
                timeLogStop = {
                    zig = {
                        "const durationNanos: f64 = @floatFromInt(timelogStart{{index}}.read()); // %s",
                        'std.debug.print("{{marker}}: {d:.3}ms", .{durationNanos / std.time.ns_per_ms});',
                    },
                },
            },
        },
    },
    {
        "glepnir/template.nvim",
        cmd = { "Template" },
        opts = {
            temp_dir = vim.fn.stdpath("config") .. "/template",
            author = "Vu Nhat Chuong",
            email = "ronnyvu321@gmail.com",
        },
    },
    {
        "gbprod/substitute.nvim",
        keys = { { "s", mode = { "n", "x" } }, { "ss" } },
        opts = {
            preserve_cursor_position = true,
            highlight_substituted_text = { timer = 40 },
        },
        config = function(_, opts)
            require("substitute").setup(opts)

            -- stylua: ignore start
            vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
            vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
            vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
            -- stylua: ignore end

            vim.cmd("hi! link SubstituteSubstituted IncSearch")
        end,
    },
    {
        "vunhatchuong/guess-indent.nvim",
        branch = "feat/auto-retab",
        cmd = { "GuessIndent" },
        opts = { auto_cmd = false },
    },
    { "AndrewRadev/linediff.vim", cmd = "Linediff" },
}

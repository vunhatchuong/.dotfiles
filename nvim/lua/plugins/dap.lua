return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                {
                    "rcarriga/nvim-dap-ui",
                    -- stylua: ignore
                    keys = {
                        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                    },
                    opts = {},
                    config = function(_, opts)
                        local dap = require("dap")
                        local dapui = require("dapui")
                        dapui.setup(opts)
                        dap.listeners.before.attach.dapui_config = function()
                            dapui.open()
                        end
                        dap.listeners.before.launch.dapui_config = function()
                            dapui.open()
                        end
                        dap.listeners.before.event_terminated.dapui_config = function()
                            dapui.close()
                        end
                        dap.listeners.before.event_exited.dapui_config = function()
                            dapui.close()
                        end
                    end,
                },
                {
                    "theHamsta/nvim-dap-virtual-text",
                    opts = {},
                },
            },
        },
        -- stylua: ignore
        keys = {
            -- { "<leader>oq", function() require("dap").close() end,             desc = "Close" },
            { "<leader>dq", function() require("dap").terminate() end,                                            desc = "Terminate" },
            { "<leader>ot", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>oc", function() require("dap").continue() end,                                             desc = "Continue" },
            { "<leader>oB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>oC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>og", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
            { "<leader>oi", function() require("dap").step_into() end,                                            desc = "Step Into" },
            -- { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            -- { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            -- { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
            { "<leader>oo", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>oO", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>op", function() require("dap").pause() end,                                                desc = "Pause" },
            -- { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            -- { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            -- { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        },
        config = function()
            local icons = require("core.icons")
            vim.api.nvim_set_hl(
                0,
                "DapStoppedLine",
                { default = true, link = "Visual" }
            )
            for name, sign in pairs(icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define("Dap" .. name, {
                    text = sign[1],
                    texthl = sign[2] or "DiagnosticInfo",
                    linehl = sign[3],
                    numhl = sign[3],
                })
            end
        end,
    },
}

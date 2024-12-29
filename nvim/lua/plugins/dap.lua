return {
    { -- For clickable Breakpoints: https://github.com/luukvbaal/statuscol.nvim
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader>dq", function() require("dap").terminate() end,                 desc = "Terminate" },
            { "<F1>",       function() require("dap").toggle_breakpoint() end,         desc = "Toggle Breakpoint" },
            { "<F2>",       function() require("dap").continue() end,                  desc = "Continue" },
            { "<F3>",       function() require("dap").step_over() end,                 desc = "Step Over" },
            { "<F4>",       function() require("dap").step_into() end,                 desc = "Step Into" },
            { "<F5>",       function() require("dap").step_out() end,                  desc = "Step Out" },
            { "<F6>",       function() require("dap").restart() end,                   desc = "Restart" },
            { "<F9>",       function() require("dap").eval(nil, { enter = true }) end, desc = "Eval var under cursor" },
        },
        config = function()
            local mason_nvim_conf = require("lazy.core.plugin").values(
                require("lazy.core.config").spec.plugins["mason-nvim-dap.nvim"],
                "opts",
                false
            )
            require("mason-nvim-dap").setup(mason_nvim_conf)
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

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,
            ensure_installed = {},
        },
        -- mason-nvim-dap is loaded when nvim-dap loads
        config = function() end,
    },
}

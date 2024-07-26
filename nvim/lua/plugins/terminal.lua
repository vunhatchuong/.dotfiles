return {
    {
        "akinsho/toggleterm.nvim",
        keys = {
            {
                "<C-\\>",
                function()
                    require("toggleterm").toggle()
                end,
                desc = "Toggle Terminal",
                mode = "n",
            },
            {
                "<C-\\>",
                function()
                    require("toggleterm").toggle()
                end,
                desc = "Toggle Terminal",
                mode = "t",
            },
            {
                "<leader>lg",
                function()
                    require("toggleterm.terminal").Terminal
                        :new({ cmd = "lazygit", hidden = true })
                        :toggle()
                end,
                desc = "Lazygit",
                mode = "n",
            },
            {
                "<leader>yz",
                function()
                    require("toggleterm.terminal").Terminal
                        :new({ cmd = "yazi", hidden = true })
                        :toggle()
                end,
                desc = "Yazi",
                mode = "n",
            },
        },
        opts = {
            direction = "float",
            float_opts = {
                border = "rounded",
            },
        },
    },
}

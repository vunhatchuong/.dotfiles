return {
    {
        "numToStr/FTerm.nvim",
        keys = {
            {
                "<C-\\>",
                function()
                    require("FTerm").toggle()
                end,
                desc = "Toggle Terminal",
                mode = "n",
            },
            {
                "<C-\\>",
                function()
                    require("FTerm").toggle()
                end,
                desc = "Toggle Terminal",
                mode = "t",
            },
            {
                "<leader>lg",
                function()
                    require("FTerm")
                        :new({
                            ft = "fterm_lazygit",
                            cmd = { "lazygit" },
                            dimensions = { height = 0.9, width = 0.9 },
                        })
                        :open()
                end,
                desc = "Lazygit",
                mode = "n",
            },
            {
                "<leader>yz",
                function()
                    require("FTerm")
                        :new({
                            ft = "fterm_yazi",
                            cmd = { "yazi" },
                            dimensions = { height = 0.9, width = 0.9 },
                        })
                        :open()
                end,
                desc = "Yazi",
                mode = "n",
            },
        },
        opts = {
            border = "rounded",
        },
        config = function(_, opts)
            require("FTerm").setup(opts)
        end,
    },
}

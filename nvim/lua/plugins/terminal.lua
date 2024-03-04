return {
    {
        "numToStr/FTerm.nvim",
        keys = {
            {
                "<leader><CR>",
                function()
                    require("FTerm").toggle()
                end,
                desc = "Toggle Terminal",
                mode = "n",
            },
            {
                "<C-_>",
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
        },
        opts = {
            border = "rounded",
        },
        config = function(_, opts)
            require("FTerm").setup(opts)
        end,
    },
}

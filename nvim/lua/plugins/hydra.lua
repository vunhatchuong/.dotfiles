return {
    {
        "nvimtools/hydra.nvim",
        keys = {
            {
                "<leader>t",
                mode = { "n" },
                function()
                    local Hydra = require("hydra")
                    local walker = Hydra({
                        name = "Tree Walker",
                        mode = { "n" },
                        hint = [[
                    Tree Walker ]],
                        -- stylua: ignore
                        heads = {
                            { "k", "<Cmd>Treewalker Up<CR>", { desc = "up" } },
                            { "j", "<Cmd>Treewalker Down<CR>", { desc = "down" } },
                            { "h", "<Cmd>Treewalker Left<CR>", { desc = "outer" } },
                            { "l", "<Cmd>Treewalker Right<CR>", { desc = "inner" } },
                        },
                    })
                    walker:activate()
                end,
                desc = "Tree Walker (Hydra)",
            },
            {
                "<leader>ts",
                mode = { "n" },
                function()
                    local Hydra = require("hydra")
                    local walker = Hydra({
                        name = "Swap Nodes",
                        mode = { "n" },
                        hint = [[
            Swap Nodes ]],
                        -- stylua: ignore
                        heads = {
                            { "k", "<CMD>Treewalker SwapUp<CR>", { desc = "up" } },
                            { "j", "<CMD>Treewalker SwapDown<CR>", { desc = "down" } },
                            { "h", "<CMD>ISwapWithLeft<CR>",  desc = "left" },
                            { "l", "<CMD>ISwapWithRight<CR>", desc = "right" },
                        },
                    })
                    walker:activate()
                end,
                desc = "Swap Nodes (Hydra)",
            },
        },
    },
}

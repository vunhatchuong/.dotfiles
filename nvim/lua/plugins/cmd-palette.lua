return {
    -- {
    --     "AxelGard/cmdwin.nvim",
    --     keys = {
    --         {
    --             "<leader>p",
    --         },
    --     },
    --     opts = {
    --         keymap = "<leader>p",
    --         command_map = {
    --             ["MD title fetch"] = "MarkdownLinkPaste",
    --             ["MD Generate TOC"] = "GenerateTOC",
    --             ["MD Delete TOC"] = "DeleteTOC",
    --             ["DataViewer"] = "DataViewer",
    --             ["TreeSort"] = "TSort",
    --         },
    --         -- navigation = {
    --         --     up = "<Up>",
    --         --     down = "<Down>",
    --         -- },
    --     },
    -- },
    {
        "fdev31/menus.nvim",
        keys = { "<leader>p" },
        opts = {},
        config = function()
            vim.keymap.set({ "n", "v" }, "<leader>p", function()
                require("menus").menu({
                    {
                        name = "󰍔 Preview Toggle",
                        cmd = "MarkdownPreviewToggle",
                    },
                    {
                        name = "󰍔 Generate TOC",
                        cmd = "GenerateTOC",
                    },
                    {
                        name = "󰍔 Delete TOC",
                        cmd = "DeleteTOC",
                    },
                    {
                        name = "󰍔 Link Paste",
                        cmd = "MarkdownLinkPaste",
                    },
                })
            end, { desc = "menus.nvim" })
        end,
    },
}

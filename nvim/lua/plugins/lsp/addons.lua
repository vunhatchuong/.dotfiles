return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        opts = {
            focus = true,
            keys = {
                ["<cr>"] = "jump_close",
                ["<space>"] = "jump",
            },
        },
        keys = {
            {
                "<leader>dd",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>wd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        },
    },
    {
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "briangwaltney/paren-hint.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    -- {
    --     "dgagn/diagflow.nvim",
    --     event = "LspAttach",
    --     opts = {
    --         scope = "line",
    --         show_borders = true,
    --         format = function(diagnostic)
    --             return diagnostic.message
    --         end,
    --     },
    -- }
    {
        "RaafatTurki/corn.nvim",
        event = "LspAttach",
        opts = {
            border_style = "rounded",
            on_toggle = function(is_hidden)
                vim.diagnostic.config({
                    virtual_text = not vim.diagnostic.config().virtual_text,
                })
            end,
            item_preprocess_func = function(item)
                return item
            end,
        },
        config = function(_, opts)
            local corn = require("corn")
            -- ensure virtual_text diags are disabled
            vim.diagnostic.config({ virtual_text = false })
            corn.setup(opts)
        end,
    },
}

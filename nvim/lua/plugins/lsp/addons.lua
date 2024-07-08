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
    -- Currently doesn't support only display current line. https://github.com/chrisgrieser/nvim-lsp-endhints/issues/3
    -- {
    --     "chrisgrieser/nvim-lsp-endhints",
    --     event = "LspAttach",
    --     opts = {},
    -- },
    {
        "Wansmer/symbol-usage.nvim",
        event = "LspAttach",
        opts = {
            request_pending_text = false,
            -- vt_position = "end_of_line",
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        opts = {
            hint_enable = false,
            hint_prefix = "󰏪 ",
            hint_scheme = "@variable.parameter",
            -- floating_window = false,
            always_trigger = true,
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
        init = function()
            vim.diagnostic.config({ virtual_text = false })
        end,
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
    },
    {
        "lewis6991/satellite.nvim",
        dependencies = {
            {
                "echasnovski/mini.diff",
            },
        },
        event = "VeryLazy",
        opts = {
            current_only = true,
            zindex = 1, -- below most stuff
            handlers = {
                cursor = { enable = false },
                -- gitsigns = { enable = false },
                -- require diff.lua
                minidiff = { enable = true },
                marks = { enable = false },
                quickfix = { enable = false },
            },
        },
        config = function(_, opts)
            require("plugins.lsp.mini-diff-satellite")
            require("satellite").setup(opts)
        end,
    },
    { -- split-join lines
        "Wansmer/treesj",
        keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
        opts = { use_default_keymaps = false, max_join_length = 150 },
    },
    {
        "Wansmer/sibling-swap.nvim",
        keys = {
			-- stylua: ignore start
			{ "<C-.>", function() require("sibling-swap").swap_with_right() end, desc = "󰔰 Move Node Right" },
			{ "<C-,>", function() require("sibling-swap").swap_with_left() end, desc = "󰶢 Move Node Left" },
            -- stylua: ignore end
        },
        opts = {
            use_default_keymaps = true,
            allowed_separators = { "..", "*" }, -- add multiplication & lua string concatenation
            highlight_node_at_cursor = true,
        },
    },
}
return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle<cr>",
                desc = "Symbols (Trouble)",
            },
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
        opts = {
            focus = true,
            keys = {
                ["<cr>"] = "jump_close",
                ["<space>"] = "jump",
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
            text_format = function(symbol)
                local fragments = {}
                if not symbol.references or symbol.references == 0 then
                    return
                end
                if symbol.references then
                    local usage = symbol.references <= 1 and "usage" or "usages"
                    local num = symbol.references
                    table.insert(fragments, ("%s %s"):format(num, usage))
                end
                return table.concat(fragments, ", ")
            end,
            -- vt_position = "end_of_line",
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufReadPre",
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
    {
        "dgagn/diagflow.nvim",
        event = "LspAttach",
        opts = {
            scope = "line",
            toggle_event = { "InsertEnter" },
            -- show_borders = true,
        },
    },
    -- Better looking but currently suffer performance issues.
    -- {
    --     "RaafatTurki/corn.nvim",
    --     event = "LspAttach",
    --     init = function()
    --         vim.diagnostic.config({ virtual_text = false })
    --     end,
    --     opts = {
    --         border_style = "rounded",
    --         on_toggle = function(is_hidden)
    --             vim.diagnostic.config({
    --                 virtual_text = not vim.diagnostic.config().virtual_text,
    --             })
    --         end,
    --         item_preprocess_func = function(item)
    --             return item
    --         end,
    --     },
    -- },
    -- {
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     event = "LspAttach",
    --     init = function()
    --         vim.diagnostic.config({
    --             virtual_text = false,
    --         })
    --     end,
    --     opts = {},
    -- },
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
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        keys = {
            {
                "<leader>ca",
                mode = { "n", "v" },
                function()
                    require("tiny-code-action").code_action()
                end,
                desc = "[C]ode [A]ction",
            },
        },
        opts = {},
    },
    {
        "danymat/neogen",
        cmd = { "Neogen" },
        opts = {
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings",
                    },
                },
            },
        },
        keys = {
            {
                "<leader>cn",
                function()
                    require("neogen").generate()
                end,
                desc = "Generate Annotations (Neogen)",
            },
        },
    },
}

return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>dd",
                ":Trouble diagnostics toggle<CR>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>wd",
                ":Trouble diagnostics toggle filter.buf=0<CR>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        },
        opts = {
            focus = true,
            keys = { ["<CR>"] = "jump_close", ["<space>"] = "jump" },
        },
    },
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
        event = "BufReadPre", -- This event type is required
        keys = {
            {
                "<leader>k",
                function()
                    vim.lsp.buf.signature_help()
                end,
                "Toggle signature help",
            },
        },
        opts = {
            hint_enable = false,
            hint_prefix = "󰏪 ",
            hint_scheme = "@variable.parameter",
            -- floating_window = false,
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
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        -- stylua: ignore
        keys = {
            { "gd",         ":Lspsaga goto_definition<CR>",      desc = "[G]oto [D]definition" },
            { "gr",         ":Lspsaga finder<CR>",               desc = "[G]oto [R]eferences" },
            { "<leader>ca", ":Lspsaga code_action<CR>",          desc = "[C]ode [A]ction" },
            { "<leader>o",  ":Lspsaga outline<CR>",              desc = "Outline (Lspsaga)" },
            { "]d",         ":Lspsaga diagnostic_jump_next<CR>", desc = "Diagnostic jump next" },
            { "[d",         ":Lspsaga diagnostic_jump_prev<CR>", desc = "Diagnostic jump prev" },
            -- { "K", ":Lspsaga hover_doc<CR>", desc = "Hover" },
        },
        opts = function()
            local icons = require("core.icons")
            return {
                ui = {
                    expand = icons.kind.Expanded,
                    collapse = icons.kind.Collapsed,
                    code_action = icons.ui.Lightbulb,
                },
                symbol_in_winbar = { enable = false },
                diagnostic = {
                    show_code_action = false,
                },
                finder = {
                    keys = {
                        toggle_or_open = "<CR>",
                    },
                },
                outline = {
                    layout = "float",
                    keys = {
                        toggle_or_jump = "<CR>",
                    },
                },
                lightbulb = { sign = false },
            }
        end,
    },
    {
        "mhanberg/output-panel.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "urizennnn/rescue-lsp.nvim",
        cmd = { "Rescue" },
        opts = {},
    },
}

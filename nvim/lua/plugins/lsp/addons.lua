return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>dd",
                ":Trouble diagnostics toggle<CR>",
                desc = "Trouble: Diagnostics",
            },
            {
                "<leader>wd",
                ":Trouble diagnostics toggle filter.buf=0<CR>",
                desc = "Trouble: Buffer Diagnostics",
            },
            {
                "<leader>o",
                ":Trouble symbols toggle<CR>",
                desc = "Trouble: Buffer Symbols",
            },
        },
        opts = {
            focus = true,
            keys = { ["<CR>"] = "jump_close", ["<space>"] = "jump" },
            modes = {
                lsp_document_symbols = {
                    title = false,
                    format = "{kind_icon} {symbol.name} {pos}",
                },
                symbols = {
                    focus = true,
                    win = { position = "bottom" },
                },
            },
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
                desc = "Toggle signature help",
            },
        },
        opts = {
            hint_enable = false,
            hint_prefix = "󰏪 ",
            hint_scheme = "@variable.parameter",
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
            { "]d",         ":Lspsaga diagnostic_jump_next<CR>", desc = "Diagnostic jump next" },
            { "[d",         ":Lspsaga diagnostic_jump_prev<CR>", desc = "Diagnostic jump prev" },
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
                    keys = { toggle_or_open = "<CR>" },
                },
                lightbulb = { sign = false },
            }
        end,
    },
    {
        "mhanberg/output-panel.nvim",
        event = "VeryLazy",
        cmd = { "OutputPanel" },
        opts = {},
    },
    {
        "kyallanum/ndi.nvim",
        cmd = { "GetLSPClientInfo", "GetPluginInfo" },
        opts = {},
    },
    {
        "smjonas/inc-rename.nvim",
        keys = { { "<leader>rn", desc = "Inc rename" } },
        opts = {
            save_in_cmdline_history = false,
        },
        config = function(_, opts)
            require("inc_rename").setup(opts)
            -- https://github.com/smjonas/dotfiles/blob/main/nvim/.config/nvim/lua/plugins/personal.lua
            vim.keymap.set("n", "<leader>rn", function()
                -- Fallback to text substitution when LSP is not available
                local cur_word = vim.fn.expand("<cword>")
                if
                    vim.tbl_isempty(vim.lsp.get_clients({
                        bufnr = vim.api.nvim_get_current_buf(),
                    }))
                then
                    return ":%s/" .. cur_word .. "//gc" .. ("<left>"):rep(3)
                else
                    return ":IncRename " .. cur_word
                end
            end, { expr = true, desc = "Start IncRename" })
        end,
    },
}

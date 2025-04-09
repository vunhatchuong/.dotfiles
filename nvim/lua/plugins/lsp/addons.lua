return {
    {
        "folke/trouble.nvim",
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>dd",
                "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
                desc = "Trouble: Buffer Diagnostics",
            },
            {
                "<leader>wd",
                "<CMD>Trouble diagnostics toggle<CR>",
                desc = "Trouble: Workspace Diagnostics",
            },
        },
        opts = {
            focus = true,
            keys = { ["<cr>"] = "jump_close", ["<space>"] = "jump" },
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
        "andymass/vim-matchup",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            vim.g.matchup_matchparen_deferred = 1 -- keystrokes get laggy without these aggro settings
            vim.g.matchup_matchparen_deferred_show_delay = 350
        end,
    },
    { -- Loaded by hover.nvim (Might not need in 0.11)
        "Fildo7525/pretty_hover",
        opts = {},
    },
    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        keys = {
            {
                "<leader>ca",
                function()
                    require("tiny-code-action").code_action()
                end,
                mode = { "n", "x" },
                desc = "TinyCodeAction: [C]ode [A]ction",
            },
        },
        opts = {
            backend = "delta",
            backend_opts = {
                delta = {
                    header_lines_to_remove = 5,
                },
            },
        },
    },
    {
        "smjonas/inc-rename.nvim",
        keys = { { "<leader>rn", desc = "Inc rename" } },
        opts = {
            save_in_cmdline_history = false,
            post_hook = function()
                vim.cmd("silent! wa")
            end,
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
    { -- Deferring of all diagnostics
        "yorickpeterse/nvim-dd",
        event = "LspAttach",
        opts = {
            timeout = 1000, -- Time before displaying new diagnostics.
        },
    },
    -- {
    --     "v1nh1shungry/error-lens.nvim",
    --     event = "LspAttach",
    --     opts = { standalone = true },
    -- },
    {
        "lafarr/hierarchy.nvim",
        cmd = "FunctionReferences",
        opts = {},
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "LspAttach",
        opts = {},
    },
}

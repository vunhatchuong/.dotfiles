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
            -- {
            --     "<leader>o",
            --     "<CMD>Trouble symbols toggle<CR>",
            --     desc = "Trouble: Buffer Symbols",
            -- },
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
            vim.g.matchup_matchparen_deferred_show_delay = 500
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        -- stylua: ignore
        keys = {
            { "gd",         "<CMD>Lspsaga goto_definition<CR>",      desc = "[G]oto [D]definition" },
            { "gr",         "<CMD>Lspsaga finder<CR>",               desc = "[G]oto [R]eferences" },
            { "<leader>ca", "<CMD>Lspsaga code_action<CR>",          desc = "[C]ode [A]ction" },
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
                code_action = { show_server_name = true },
            }
        end,
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
    { -- Auto launch when lsp.keymap.workspace_diagnostics run
        "artemave/workspace-diagnostics.nvim",
        opts = {},
    },
    {
        "Bekaboo/dropbar.nvim",
        enabled = false,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        init = function()
            -- Disable dropbar's own lazy loader
            vim.g.loaded_dropbar = true
        end,
        ---@type dropbar_configs_t
        opts = {
            icons = {
                kinds = {
                    symbols = require("core.icons").kind,
                },
            },
            bar = {
                update_debounce = 3000,
                sources = function(buf, _)
                    local sources = require("dropbar.sources")
                    local utils = require("dropbar.utils")
                    if vim.bo[buf].ft == "markdown" then
                        return {
                            sources.path,
                            sources.markdown,
                        }
                    end
                    if vim.bo[buf].buftype == "terminal" then
                        return {
                            sources.terminal,
                        }
                    end
                    return {
                        utils.source.fallback({
                            sources.lsp,
                            sources.treesitter,
                        }),
                    }
                end,
            },
        },
    },
    { -- Stop lsp in inactive nvim instances
        -- Doesn't work for all lsp
        "tronikelis/lsp-gc.nvim",
        enabled = false,
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        opts = {},
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
}

local icons = require("core.icons")
return {
    -- {
    --     "supermaven-inc/supermaven-nvim",
    --     build = ":SupermavenUseFree",
    --     cmd = "SupermavenToggle",
    --     opts = {
    --         log_level = "off",
    --         disable_keymaps = true,
    --         disable_inline_completion = true,
    --         ignore_filetypes = {
    --             gitcommit = true,
    --             TelescopePrompt = true,
    --         },
    --     },
    -- },
    {
        "saghen/blink.cmp",
        version = "v0.*",
        opts_extend = { "sources.default" },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        --- @diagnostic disable: missing-fields
        opts = {
            keymap = {
                preset = "enter",
                ["<C-e>"] = {},

                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

                ["<C-p>"] = {},
                ["<C-n>"] = {},

                ["<C-b>"] = {},
                ["<C-f>"] = {},

                cmdline = {
                    preset = "enter",

                    ["<C-e>"] = {},

                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },

                    ["<C-p>"] = {},
                    ["<C-n>"] = {},

                    ["<C-b>"] = {},
                    ["<C-f>"] = {},
                },
            },
            completion = {
                list = { selection = "manual" },
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    border = vim.g.bordor_style,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "kind_icon", "kind", gap = 1 },
                            { "label", "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                    -- Don't auto popup completion menu
                    -- auto_show = false,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = vim.g.bordor_style },
                },
            },
            -- Experimental signature help support
            -- Already use ray-x/lsp_signature.nvim
            signature = {
                -- enabled = true,
                window = { border = vim.g.bordor_style },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                -- Don't show completion if len(cmd) < 2 words
                -- https://github.com/Saghen/blink.cmp/issues/585
                min_keyword_length = function(ctx)
                    if
                        ctx.mode == "cmdline"
                        and string.find(ctx.line, " ") == nil
                    then
                        return 2
                    end
                    return 0
                end,
                providers = {
                    lsp = {
                        name = "[LSP]",
                        score_offset = 4,
                    },
                    snippets = {
                        -- don't show when triggered manually (= length 0), useful
                        -- when manually showing completions to see available JSON keys
                        min_keyword_length = 1,
                        score_offset = 3,
                    },
                    path = {
                        name = "[Path]",
                        score_offset = 2,
                    },
                    buffer = {
                        name = "[Buffer]",
                        max_items = 4,
                        min_keyword_length = 4,
                        score_offset = 1,
                    },
                },
            },
            appearance = { kind_icons = icons.kind },
        },
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "[LazyDev]",
                        module = "lazydev.integrations.blink",
                        score_offset = 100, -- show at a higher priority than lsp
                    },
                },
            },
        },
    },
    {
        "philosofonusus/ecolog.nvim",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "saghen/blink.cmp",
            "nvimdev/lspsaga.nvim",
        },
        keys = {
            {
                "<leader>fe",
                ":Telescope ecolog env<CR>",
                desc = "Ecolog: [F]ind [E]nvironment",
            },
        },
        opts = {
            path = Util.get_folder_location(),
            -- preferred_environment = "local",
            types = true,
            integrations = {
                lspsaga = true,
                blink_cmp = true,
                nvim_cmp = false,
                telescope = true,
            },
            shelter = {
                configuration = { partial_mode = true },
                modules = {
                    files = true,
                    peek = true,
                    telescope = true,
                    cmp = true,
                },
            },
        },
        config = function(_, opts)
            require("ecolog").setup(opts)
            require("telescope").load_extension("ecolog")
        end,
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "ecolog" },
                providers = {
                    ecolog = {
                        name = "[Ecolog]",
                        module = "ecolog.integrations.cmp.blink_cmp",
                        score_offset = 101,
                    },
                },
            },
        },
    },
}

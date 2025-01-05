return {
    {
        "stevearc/oil.nvim",
        enabled = false,
        dependencies = { "echasnovski/mini.icons" },
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open()
                end,
                desc = "Oil: Open",
            },
        },
        --- @type oil.SetupOpts
        opts = {
            skip_confirm_for_simple_edits = true,
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            watch_for_changes = true,
            keymaps = {
                ["l"] = "actions.select",
                ["h"] = "actions.parent",
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-t>"] = false,
                ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["_"] = false,
                ["`"] = false,
                ["~"] = false,
                ["gs"] = false,
                ["ge"] = "actions.open_external",
                ["."] = "actions.toggle_hidden",
            },
            view_options = {
                show_hidden = true,
            },
            win_options = {
                number = false,
                relativenumber = false,
                signcolumn = "yes:2",
                statuscolumn = "",
            },
            lsp_file_methods = { autosave_changes = true },
        },
    },
    { "FerretDetective/oil-git-signs.nvim", ft = "oil", opts = {} },
    {
        "echasnovski/mini.files",
        lazy = false,
        dependencies = { "v1nh1shungry/mini-files-status.nvim" },
        keys = {
            {
                "<leader>e",
                function()
                    if not MiniFiles.close() then
                        MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
                    end
                end,
                desc = "Mini.files: Open",
            },
        },
        opts = {
            windows = {
                preview = true,
                width_focus = 30,
                width_preview = 50,
            },
            mappings = {
                close = "q",
                go_in = "",
                go_in_plus = "L",
                go_out = "",
                go_out_plus = "H",
                mark_goto = "",
                mark_set = "",
                reset = "<BS>",
                reveal_cwd = "@",
                synchronize = "<enter>",
            },
        },
        config = function(_, opts)
            require("mini.files").setup(opts)

            local show_dotfiles = true
            local filter_show = function(fs_entry)
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                require("mini.files").refresh({
                    content = { filter = new_filter },
                })
            end

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id

                    vim.keymap.set(
                        "n",
                        opts.mappings and opts.mappings.toggle_hidden or "g.",
                        toggle_dotfiles,
                        { buffer = buf_id, desc = "Toggle hidden files" }
                    )
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowOpen",
                callback = function(args)
                    local win_id = args.data.win_id

                    vim.wo[win_id].winblend = 0

                    local config = vim.api.nvim_win_get_config(win_id)

                    config.border = vim.g.border_style
                    config.height = 45

                    vim.api.nvim_win_set_config(win_id, config)
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesWindowUpdate",
                callback = function(args)
                    local config = vim.api.nvim_win_get_config(args.data.win_id)

                    config.border = vim.g.border_style
                    config.height = 45

                    vim.api.nvim_win_set_config(args.data.win_id, config)
                end,
            })

            -- LSP-integrated file renaming
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesActionRename",
                callback = function(event)
                    Snacks.rename.on_rename_file(event.data.from, event.data.to)
                end,
            })
        end,
    },
}

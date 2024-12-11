return {
    {
        "stevearc/oil.nvim",
        lazy = false,
        dependencies = { "echasnovski/mini.icons" },
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open()
                end,
                desc = "Open file explorer",
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
    {
        "FerretDetective/oil-git-signs.nvim",
        ft = "oil",
        opts = {},
    },
}

local icons = require("core.icons")
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable("make") == 1,
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
                opts = {},
                config = function()
                    require("telescope").setup({
                        extensions = {
                            ["ui-select"] = {
                                require("telescope.themes").get_dropdown({}),
                            },
                        },
                    })

                    require("telescope").load_extension("ui-select")
                end,
            },
        },
        -- stylua: ignore
        keys = {
            {
                "<leader><space>",
                function()
                    local activeClients = vim.lsp.get_active_clients()

                    local workspaceFolder
                    if activeClients[2] then
                        workspaceFolder = activeClients[2].config.root_dir
                        require("telescope.builtin").find_files({
                            cwd = workspaceFolder,
                        })
                        return
                    else
                        require("telescope.builtin").find_files()
                    end
                end,
                desc = "Find Files",
            },

            { "<leader>f?", function() require("telescope.builtin").oldfiles() end,     desc = "Find recently opened Files" },
            { "<leader>ft", function() require("telescope.builtin").live_grep() end,    desc = "[F]ind [T]ext" },
            { "<leader>fs", function() require("telescope.builtin").grep_string() end,  desc = "[F]ind [S]tring" },
            { "<leader>fk", function() require("telescope.builtin").keymaps() end,      desc = "Keymaps" },
            { "<leader>fg", function() require("telescope.builtin").git_files() end,    desc = "Find Git Files" },
            { "<leader>gc", function() require("telescope.builtin").git_branches() end, desc = "Checkout branches" },
        },
        opts = {
            defaults = {
                prompt_prefix = icons.ui.Telescope .. " ",
                selection_caret = icons.ui.Forward .. "  ",
                entry_prefix = "   ",
                path_display = { "smart" },
            },
        },
    },
}

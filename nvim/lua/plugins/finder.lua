local icons = require("core.icons")

local function FolderLocation()
    local activeClients = require("lspconfig").util.get_managed_clients()

    local path = vim.fn.getcwd()
    local prompt_title = "Default"

    if #activeClients > 0 then
        path = activeClients[1].config.root_dir
        prompt_title = activeClients[1].name
    elseif vim.fs.root(0, ".git") then
        path = vim.fs.root(0, ".git")
        prompt_title = "Git root"
    end

    return path, prompt_title
end
return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
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
                desc = "Find Files",
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").find_files({
                        cwd = path,
                        prompt_title = prompt_title,
                        previewer = false,
                        layout_config = {
                            width = 0.6,
                            height = 0.8,
                        }})
                end
            },
            {   "<leader>f?",
                desc = "Find recently opened Files",
                function() require("telescope.builtin").oldfiles({
                    previewer = false,
                    layout_config = {
                        width = 0.6,
                        height = 0.8,
                    }})
                end
            },
            {
                "<leader>ft",
                desc = "[F]ind [T]ext",
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").live_grep({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end
            },
            {
                "<leader>fs",
                desc = "[F]ind [S]tring",
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").grep_string({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end
            },
            { "<leader>fk",
                desc = "View Keymaps",
                function() require("telescope.builtin").keymaps() end
            },
            { "<leader>gc",
                desc = "Checkout branches",
                function() require("telescope.builtin").git_branches() end
            },
        },
        opts = {
            defaults = {
                prompt_prefix = icons.ui.Telescope .. " ",
                selection_caret = icons.ui.Forward .. "  ",
                entry_prefix = "   ",
                path_display = { "smart" },
                mappings = {
                    n = {
                        ["q"] = "close",
                    },
                    i = {
                        ["<ESC>"] = "close",
                    },
                },
            },
        },
    },
}

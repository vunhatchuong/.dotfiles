local icons = require("core.icons")

local function FolderLocation()
    local activeClients = require("lspconfig").util.get_managed_clients()
    local path = vim.fn.expand("%:p:h")
    local prompt_title = "Default"
    for _, client in ipairs(activeClients) do
        path = client.config.root_dir
        prompt_title = client.name
        return path, prompt_title
    end
    local prefixes = { "oil:///", "other:///", "netrw:///" }
    -- Not working on Windows because oil path missing `:`
    path = path:gsub("^" .. prefixes[1], "")
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
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").find_files({
                        cwd = path, prompt_title = prompt_title,
                    })
                end, desc = "Find Files", },
            { "<leader>f?",
                function() require("telescope.builtin").oldfiles() end, desc = "Find recently opened Files",
            },
            {
                "<leader>ft",
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").live_grep({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end, desc = "[F]ind [T]ext", },
            {
                "<leader>fs",
                function()
                    local path, prompt_title = FolderLocation()
                    require("telescope.builtin").grep_string({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end, desc = "[F]ind [S]tring", },
            { "<leader>fk",
                function() require("telescope.builtin").keymaps() end, desc = "Keymaps",
            },
            { "<leader>gc",
                function() require("telescope.builtin").git_branches() end, desc = "Checkout branches",
            },
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

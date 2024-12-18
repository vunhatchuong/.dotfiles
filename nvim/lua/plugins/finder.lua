return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = vim.fn.executable("make") == 1 and "make",
                enabled = vim.fn.executable("make") == 1
                    or vim.fn.executable("zig") == 1,

                -- stylua: ignore
                config = function(plugin)
                    local ok, err =
                        pcall(require("telescope").load_extension, "fzf")
                    if not ok then
                        if not vim.uv.fs_stat(plugin.dir .. "/build/libfzf.dll")
                        then
                            local lib = plugin.dir
                            vim.notify("Rebuilding `telescope-fzf-native.nvim`")
                            vim.fn.mkdir(lib .. "/build", "p")
                            vim.fn.system("zig cc -O3 -Wall -Werror -fpic -std=gnu99 -shared "
                                .. lib .. "/src/fzf.c -o " .. lib .. "/build/libfzf.dll")
                        else
                            vim.notify("Failed to load `telescope-fzf-native.nvim`:\n"
                                .. err)
                        end
                    end
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
                    local path, prompt_title = Util.telescope.get_folder_location()
                    require("telescope.builtin").find_files({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end
            },
            {
                "<leader>ft",
                desc = "[F]ind [T]ext",
                function()
                    local path, prompt_title = Util.telescope.get_folder_location()
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
                    local path, prompt_title = Util.telescope.get_folder_location()
                    require("telescope.builtin").grep_string({
                        cwd = path,
                        prompt_title = prompt_title,
                    })
                end
            },
        },
        opts = function()
            local icons = require("core.icons")

            return {
                defaults = {
                    prompt_prefix = " " .. icons.ui.Telescope .. " ",
                    selection_caret = " " .. icons.ui.Forward,
                    entry_prefix = "   ",
                    path_display = { "smart" },
                    mappings = {
                        n = { ["q"] = "close" },
                        i = { ["<ESC>"] = "close" },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = Util.telescope.find_command,
                        hidden = true,
                        previewer = false,
                        layout_config = { width = 0.6, height = 0.8 },
                    },
                },
            }
        end,
    },
}

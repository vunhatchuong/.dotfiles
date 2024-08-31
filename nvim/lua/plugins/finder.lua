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
                build = vim.fn.executable("make") == 1 and "make",
                enabled = vim.fn.executable("make") == 1
                    or vim.fn.executable("zig") == 1,
                -- stylua: ignore start
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
                -- stylua: ignore end
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
        opts = function()
            local actions = require("telescope.actions")
            -- stylua: ignore start
            local function find_command()
                if 1 == vim.fn.executable("rg") then
                return { "rg", "--files", "--color", "never", "-g", "!.git" }
                elseif 1 == vim.fn.executable("rg") then
                return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("fdfind") then
                return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
                elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
                return { "find", ".", "-type", "f" }
                elseif 1 == vim.fn.executable("where") then
                return { "where", "/r", ".", "*" }
                end
            end
            -- stylua: ignore end
            return {
                defaults = {
                    prompt_prefix = " " .. icons.ui.Telescope .. " ",
                    selection_caret = " " .. icons.ui.Forward,
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
                pickers = {
                    find_files = {
                        find_command = find_command,
                        hidden = true,
                    },
                },
            }
        end,
    },
}

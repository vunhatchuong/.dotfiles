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
        },
        keys = {
            {
                "<leader><space>",
                function()
                    local prefixes = { "oil://", "other://", "netrw://" }
                    local currentPath = vim.fn.expand("%:p:h")
                    local workspaceFolders = vim.lsp.buf.list_workspace_folders()
                        or {}

                    local matchingFolder
                    for _, folder in ipairs(workspaceFolders) do
                        if currentPath:find(folder, 1, true) then
                            matchingFolder = folder
                            break
                        end
                    end

                    local path = matchingFolder and matchingFolder
                        or currentPath
                    path = path:gsub("^" .. prefixes[1], "")

                    require("telescope.builtin").find_files({
                        cwd = path,
                        prompt_title = matchingFolder
                            and "Files in matching workspace folder"
                            or "Files with prefix removed",
                    })
                end,

                desc = "Find Files",
            },
            {
                "<leader>f?",
                function()
                    require("telescope.builtin").oldfiles()
                end,
                desc = "Find recently opened Files",
            },
            {
                "<leader>ft",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Find text",
            },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").grep_string()
                end,
                desc = "Find string",
            },
            {
                "<leader>fk",
                function()
                    require("telescope.builtin").keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>fg",
                function()
                    require("telescope.builtin").git_files()
                end,
                desc = "Find Git Files",
            },
            {
                "<leader>gc",
                function()
                    require("telescope.builtin").git_branches()
                end,
                desc = "Checkout branches",
            },
        },
    },
}

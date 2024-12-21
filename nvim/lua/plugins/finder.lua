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
        -- keys = {
        --     {
        --         "<leader><space>",
        --         desc = "Find Files",
        --         function()
        --             local path, prompt_title = Util.get_folder_location()
        --             require("telescope.builtin").find_files({
        --                 cwd = path,
        --                 prompt_title = prompt_title,
        --             })
        --         end
        --     },
        --     {
        --         "<leader>ft",
        --         desc = "[F]ind [T]ext",
        --         function()
        --             local path, prompt_title = Util.get_folder_location()
        --             require("telescope.builtin").live_grep({
        --                 cwd = path,
        --                 prompt_title = prompt_title,
        --             })
        --         end
        --     },
        --     {
        --         "<leader>fs",
        --         desc = "[F]ind [S]tring",
        --         function()
        --             local path, prompt_title = Util.get_folder_location()
        --             require("telescope.builtin").grep_string({
        --                 cwd = path,
        --                 prompt_title = prompt_title,
        --             })
        --         end
        --     },
        -- },
        opts = function()
            local icons = require("core.icons")

            return {
                defaults = {
                    prompt_prefix = " " .. icons.ui.Telescope .. " ",
                    selection_caret = " " .. icons.ui.Forward,
                    results_title = false,
                    entry_prefix = "   ",
                    path_display = { "smart" },
                    sorting_strategy = "ascending",
                    layout_config = { horizontal = { prompt_position = "top" } },
                    mappings = {
                        n = { ["q"] = "close" },
                        i = { ["<ESC>"] = "close" },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = Util.finder.find_command,
                        hidden = true,
                        previewer = false,
                        layout_config = {
                            horizontal = { prompt_position = "top" },
                            width = 0.6,
                            height = 0.8,
                        },
                    },
                    live_grep = { disable_coordinates = true },
                    highlights = {
                        -- stylua: ignore
                        mappings = {
                            i = { -- copy highlight values
                                ["<CR>"] = function(promptBufnr)
                                    local hlName = require("telescope.actions.state").get_selected_entry().value

                                    require("telescope.actions").close(promptBufnr)

                                    local hlValue = vim.api.nvim_get_hl(0, { name = hlName })
                                    local out = vim.iter(hlValue):fold({}, function(acc, key, val)
                                        if key == "link" then acc.link = val end
                                        if key == "fg" then acc.fg = ("#%06x"):format(val) end
                                        if key == "bg" then acc.bg = ("#%06x"):format(val) end
                                        return acc
                                    end)
                                    if vim.tbl_isempty(out) then return end

                                    local values = table.concat(vim.tbl_values(out), "\n")
                                    vim.fn.setreg("+", values)
                                end,
                            },
                        },
                    },
                },
            }
        end,
    },
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        -- stylua: ignore
        keys = {
            {
                "<leader><space>",
                desc = "Find Files",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").files({
                        cwd = path,
                        winopts = { title = prompt_title }
                    })
                end
            },
            {
                "<leader>ft",
                desc = "[F]ind [T]ext",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").live_grep_native({
                        cwd = path,
                        winopts = { title = prompt_title }
                    })
                end
            },
            {
                "<leader>fs",
                desc = "[F]ind [S]tring",
                function()
                    local path, prompt_title = Util.get_folder_location()
                    require("fzf-lua").grep_cword({
                        cwd = path,
                        winopts = { title = prompt_title }
                    })
                end
            },
        },
        init = function()
            require("lazy").load({ plugins = { "fzf-lua" } })
            require("fzf-lua").register_ui_select()
        end,
        opts = {
            "default-title",
            fzf_colors = true,
            defaults = {
                -- formatter = "path.filename_first",
                formatter = "path.dirname_first",
            },
            winopts = {
                preview = {
                    scrollbar = false,
                    delay = 10,
                    winopts = { number = false },
                },
            },
            previewers = {
                builtin = {
                    extensions = {
                        ["png"] = Util.finder.image_previewer(),
                        ["jpg"] = Util.finder.image_previewer(),
                        ["jpeg"] = Util.finder.image_previewer(),
                        ["svg"] = { "chafa" },
                        ["gif"] = Util.finder.image_previewer(),
                        ["webp"] = Util.finder.image_previewer(),
                    },
                    ueberzug_scaler = "fit_contain",
                },
            },
            files = {
                previewer = false,
                winopts = {
                    width = 0.6,
                    height = 0.8,
                },
            },
            lsp = {
                async = true,
                jump_to_single_result = true,
                -- ignore_current_line = true,
                code_actions = {
                    previewer = vim.fn.executable("delta") == 1
                            and "codeaction_native"
                        or nil,
                },
            },
            oldfiles = {
                include_current_session = true,
            },
            keymap = {
                builtin = {
                    true,
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    true,
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                },
            },
        },
        config = function(_, opts)
            if opts[1] == "default-title" then
                local function fix(t)
                    t.prompt = t.prompt ~= nil and " " or nil
                    for _, v in pairs(t) do
                        if type(v) == "table" then
                            fix(v)
                        end
                    end
                    return t
                end
                opts = vim.tbl_deep_extend(
                    "force",
                    fix(require("fzf-lua.profiles.default-title")),
                    opts
                )
                opts[1] = nil
            end
            require("fzf-lua").setup(opts)
        end,
    },
}

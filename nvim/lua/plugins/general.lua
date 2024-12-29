return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "Undo Tree" },
        },
    },
    {
        "chrisgrieser/nvim-early-retirement",
        event = "BufAdd",
        opts = {
            -- retirementAgeMins = 20,
            notificationOnAutoClose = true,
            deleteBufferWhenFileDeleted = true,
        },
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<Left>",  function() require("origami").h() end },
            { "<Right>", function() require("origami").l() end },
        },
        opts = {
            -- This breaks fileline.nvim and actually.nvim
            keepFoldsAcrossSessions = false,
        },
    },
    { -- Turn off features when file > ? MB
        "pteroctopus/faster.nvim",
        lazy = false,
        opts = {
            behaviours = {
                bigfile = {
                    on = true,
                    filesize = 2,
                },
            },
        },
    },
    -- open file given a line, Ex in terminal: nvim general.lua:20
    { "lewis6991/fileline.nvim", event = "BufNewFile" },
    -- Ask when try to open a disambiguate file: nvim gener
    {
        "vunhatchuong/actually.nvim",
        branch = "fix/nested-autocmd",
        event = "BufNewFile",
    },
    {
        "lewis6991/hover.nvim",
        -- stylua: ignore
        keys = { { "K", function() require("hover").hover() end } },
        opts = {
            init = function()
                -- require("hover.providers.lsp")
                require("plugins.lsp.lspsaga-hover")
                require("hover.providers.fold_preview")
                require("hover.providers.man")
                require("hover.providers.dictionary")
            end,
            preview_opts = { border = vim.g.border_style },
        },
    },
    { "psjay/buffer-closer.nvim", keys = { "q" }, opts = {} },
    { -- Keep cursor position when yank
        "svban/YankAssassin.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = { auto_normal = true, auto_visual = true },
    },
    { -- Install distant then run :DistantConnect ssh://{username}@{IP}
        "chipsenkbeil/distant.nvim",
        cmd = { "DistantInstall", "DistantConnect", "DistantLaunch" },
        opts = {
            ["network.private"] = true,
            -- manager = {
            --     log_file = "/tmp/manager.log",
            --     log_level = "trace",
            -- },
        },
        config = function(_, opts)
            require("distant"):setup(opts)
        end,
    },
    {
        "mistricky/codesnap.nvim",
        -- Doesn't support Windows yet
        enabled = vim.fn.has("Linux") == 1,
        build = "make",
        -- stylua: ignore
        cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapASCII", "CodeSnapHighlight" },
        keys = {
            {
                "<leader>xs",
                mode = { "n", "x" },
                desc = "CodeSnap",
                "<CMD>CodeSnap<CR>",
            },
            {
                "<leader>xS",
                mode = { "n", "x" },
                desc = "CodeSnap: Save",
                "<CMD>CodeSnapSave<CR>",
            },
        },
        opts = {
            save_path = "~/Pictures",
            mac_window_bar = false,
            has_breadcrumbs = true,
            show_workspace = true,
            has_line_number = true,
            bg_theme = "peach",
            -- bg_color = "#535c68",
        },
    },
    {
        "HakonHarnes/img-clip.nvim",
        cmd = { "PasteImage" },
        keys = {
            {
                "<leader>p",
                function()
                    local telescope = require("telescope.builtin")
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    telescope.find_files({
                        attach_mappings = function(_, map)
                            local function embed_image(prompt_bufnr)
                                local entry = action_state.get_selected_entry()
                                local filepath = entry[1]
                                actions.close(prompt_bufnr)

                                require("img-clip").paste_image(nil, filepath)
                            end

                            map("i", "<CR>", embed_image)
                            map("n", "<CR>", embed_image)

                            return true
                        end,
                    })
                end,
                desc = "Paste Image",
            },
        },
        opts = {},
    },
    {
        "rlychrisg/truncateline.nvim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            -- Note: Make it less than sidescrolloff
            line_start_length = 15,
        },
    },
    {
        "lalitmee/browse.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        keys = {
            {
                "<leader>b",
                function()
                    require("browse").open_bookmarks()
                end,
                desc = "Browse: Bookmarks",
            },
            {
                "<leader>bd",
                function()
                    require("browse.devdocs").search()
                end,
                desc = "Browse: Dev docs",
            },
            {
                "<leader>bf",
                function()
                    require("browse.devdocs").search_with_filetype()
                end,
                desc = "Browse: Search for current ft",
            },
        },
        opts = {
            provider = "duckduckgo",
            bookmarks = {
                ["personal"] = {
                    ["github"] = "https://github.com/vunhatchuong",
                    ["dotfiles"] = "https://github.com/vunhatchuong/.dotfiles",
                },
                ["docs"] = {
                    ["zig:std"] = "https://ziglang.org/documentation/master/std/",
                    ["RFC"] = "https://www.rfc-editor.org/search/rfc_search_detail.php",
                },
                ["entertainment"] = {
                    ["awesome-nvim"] = "https://github.com/rockerBOO/awesome-neovim",
                    ["neovim_reddit"] = "https://www.reddit.com/r/neovim/",
                    ["unix-porn_reddit"] = "https://www.reddit.com/r/unixporn/",
                },
            },
            icons = {
                bookmarks_prompt = "󰂺 ",
                bookmark_alias = " ",
                grouped_bookmarks = "|",
            },
        },
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<CMD>Browse<CR>", mode = { "n", "x" } } },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        opts = {
            handlers = {
                brewfile = false,
            },
            handler_options = { search_engine = "duckduckgo" },
        },
    },
    { -- Allow to search in visual

        "aliqyan-21/wit.nvim",
        cmd = { "WitSearch", "WitSearchVisual" },
        opts = {
            engine = "duckduckgo",
        },
    },
    {
        "mei28/Weview.nvim",
        cmd = { "Weview" },
        opts = {
            search_urls = {
                DuckDuckGo = "https://duckduckgo.com/?q=",
                GitHub = "https://github.com/search?q=%s",

                -- Programming
                XinY = "https://learnxinyminutes.com/docs/%s",
                ["pkg.go.dev"] = "https://pkg.go.dev/search?q=%s",
            },
            aliases = {
                s = "DuckDuckGo",
                gh = "GitHub",
                -- Programming
                go = "pkg.go.dev",
            },
            command_name = "Weview",
        },
    },
    { -- Works in WSL and customize open_cmd
        "KaitoMuraoka/websearcher.nvim",
        cmd = { "Websearch" },
        opts = {
            open_cmd = "wsl-open",
            search_engine = "DuckDuckGo",
        },
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { "ibhagwan/fzf-lua" },
        keys = {
            "y",
            "d",
            {
                "<leader>y",
                "<CMD>lua require('neoclip.fzf')()<CR>",
                desc = "Neoclip",
            },
        },
        opts = {
            history = 10,
            enable_macro_history = false,
            filter = function(data)
                local function is_whitespace(line)
                    return vim.fn.match(line, [[^\s*$]]) ~= -1
                end

                local function all(tbl, check)
                    for _, entry in ipairs(tbl) do
                        if not check(entry) then
                            return false
                        end
                    end
                    return true
                end
                return not all(data.event.regcontents, is_whitespace)
            end,
            default_register = { '"', "+" },
        },
    },
    {
        "meznaric/key-analyzer.nvim",
        cmd = { "KeyAnalyzer" },
        opts = {},
    },
    { -- Suggest keybinds based on description
        "tris203/hawtkeys.nvim",
        cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            keyboardLayout = "qwerty", ---@type "qwerty"|"colemak-dh"
        },
    },
    {
        "philosofonusus/ecolog.nvim",
        event = "BufRead",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "saghen/blink.cmp",
            "nvimdev/lspsaga.nvim",
        },
        keys = {
            {
                "<leader>fe",
                "<CMD>Telescope ecolog env<CR>",
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
                telescope = true,
            },
            shelter = {
                configuration = {
                    partial_mode = true,
                    mask_char = "•",
                },
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
        "nacro90/numb.nvim",
        event = { "CmdlineEnter" },
        opts = {},
    },
    {
        "psliwka/vim-dirtytalk",
        lazy = false,
        build = ":DirtytalkUpdate",
        config = function()
            vim.opt.spelllang:append("programming")
        end,
    },
    { -- https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variables

        "chrisgrieser/nvim-scissors",
        dependencies = "ibhagwan/fzf-lua",
        keys = {
            {
                "<leader>na",
                function()
                    require("scissors").addNewSnippet()
                end,
                mode = { "n", "x" },
                desc = "󰩫 Add",
            },
            {
                "<leader>nn",
                function()
                    require("scissors").editSnippet()
                end,
                desc = "󰩫 Edit",
            },
        },
        opts = {
            jsonFormatter = "jq",
        },
    },
    {
        "tamton-aquib/stuff.nvim",
        lazy = false,
        cmd = { "Calc" },
        config = function()
            require("calc").setup()
            -- require("rain").rain()
        end,
    },
}

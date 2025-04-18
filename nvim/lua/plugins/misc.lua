return {
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
        version = "*",
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
                ["doc.rust-lang"] = "https://doc.rust-lang.org/std/index.html?search=%s",
            },
            aliases = {
                s = "DuckDuckGo",
                gh = "GitHub",
                -- Programming
                go = "pkg.go.dev",
                rust = "doc.rust-lang",
            },
            command_name = "Weview",
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
                    ["gleam:tour"] = "https://tour.gleam.run/everything/",
                    ["gleam:std"] = "https://hexdocs.pm/gleam_stdlib/",
                    ["rust:std"] = "https://doc.rust-lang.org/std/index.html"
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
        "ZWindL/orphans.nvim",
        cmd = "Orphans",
        opts = {},
    },
    {
        "moniquelive/rfc.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("rfc")
        end,
    },
    { -- loremX, ploremX cmd
        "maarutan/lorem.nvim",
        opts = {},
    },
    { -- blink.nvim source
        "dnnr1/lorem-ipsum.nvim",
    },
}

-- https://mason-registry.dev/registry/list
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            "mason.nvim",
            { "williamboman/mason-lspconfig.nvim", config = function() end },
            require("plugins.lsp.mason"),
        },
        opts = function()
            return {
                inlay_hints = {
                    enabled = false,
                },
                codelens = {
                    enabled = false,
                },
                -- Enable lsp cursor word highlighting
                document_highlight = {
                    enabled = false,
                },
                -- add any global capabilities here
                -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                -- options for vim.lsp.buf.format
                format = {
                    formatting_options = nil,
                    timeout_ms = nil,
                },
                -- LSP Server Settings
                --- @type lspconfig.Config
                --- @diagnostic disable: missing-fields
                servers = {
                    lua_ls = {
                        -- Use this to add any additional keymaps
                        -- for specific lsp servers
                        -- ---@type LazyKeysSpec[]
                        -- keys = {},
                        settings = {
                            Lua = {
                                workspace = {
                                    checkThirdParty = false,
                                },
                                codeLens = {
                                    enable = true,
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                doc = {
                                    privateName = { "^_" },
                                },
                                hint = {
                                    enable = true,
                                    setType = false,
                                    paramType = true,
                                    paramName = "Disable",
                                    semicolon = "Disable",
                                    arrayIndex = "Disable",
                                },
                            },
                        },
                    },
                },

                -- attach_server = {
                --     lua_ls = function(client, event)
                --         vim.api.nvim_buf_set_var(event.buf, "shiftwidth", 4)
                --         vim.api.nvim_buf_set_var(event.buf, "tabstop", 4)
                --         -- Disable hover
                --         client.server_capabilities.hoverProvider = false
                --     end,
                -- },

                -- you can do any additional lsp server setup here
                -- return true if you don't want this server to be setup with lspconfig
                ---@type table<string, fun(server:string, opts:lspconfig.Config):boolean?>
                setup = {
                    -- example to setup with typescript.nvim
                    -- tsserver = function(_, opts)
                    --   require("typescript").setup({ server = opts })
                    --   return true
                    -- end,
                    -- DOCS https://github.com/tekumara/typos-lsp/blob/main/docs/neovim-lsp-config.md
                    typos_lsp = function(_, opts)
                        opts.init_options = { diagnosticSeverity = "Hint" }
                        return false
                    end,
                    -- Specify * to use this function as a fallback for any server
                    -- return true to only apply this opts
                    ["*"] = function(_, opts)
                        -- opts.on_attach =
                        --     require("plugins.lsp.handler").workspace_diagnostics
                        return false
                    end,
                },
            }
        end,
        config = function(_, opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = require("plugins.lsp.keymaps").on_attach,
            })

            local servers = opts.servers

            -- Merge capabilities from all servers
            -- Setup auto complete
            local has_blink, blink = pcall(require, "blink.cmp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_blink and blink.get_lsp_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if server_opts.enabled == false then
                    return
                end

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end

                opts.attach_server = opts.attach_server or {}

                -- Custom attach_server field to configure the server after attach
                -- https://github.com/XavierChanth/dotfiles/blob/trunk/dotfiles/dot-config/nvim/lua/editor/lsp.lua#L182
                if opts.attach_server[server] then
                    vim.api.nvim_create_autocmd("LspAttach", {
                        callback = function(event)
                            local client =
                                vim.lsp.get_client_by_id(event.data.client_id)
                            if client and client.name == server then
                                if
                                    opts.attach_server[server](
                                        client,
                                        event,
                                        server_opts[server]
                                    )
                                then
                                    return
                                end
                            end
                        end,
                    })
                end

                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    setup(server)
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = vim.tbl_deep_extend(
                        "force",
                        ensure_installed,
                        require("lazy.core.plugin").values(
                            require("lazy.core.config").spec.plugins["mason-lspconfig.nvim"],
                            "opts",
                            false
                        ).ensure_installed or {}
                    ),
                    handlers = { setup },
                })
            end

            require("plugins.lsp.diagnostics").setup()
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
                { path = "lazy.nvim", words = { "LazyVim" } },
            },
        },
    },
    { import = "plugins.lsp.addons" },
}

-- https://mason-registry.dev/registry/list
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            "mason.nvim",
            { "williamboman/mason-lspconfig.nvim", config = function() end },
        },
        init = function()
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = vim.g.bordor_style }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = vim.g.bordor_style }
            )
            require("lspconfig.ui.windows").default_options.border =
                vim.g.bordor_style
        end,
        opts = function()
            return {
                inlay_hints = {
                    enabled = false,
                    exclude = {}, -- filetypes for which you don't want to enable inlay hints
                },
                -- https://github.com/neovim/neovim/issues/29156
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
                -- you can do any additional lsp server setup here
                -- return true if you don't want this server to be setup with lspconfig
                ---@type table<string, fun(server:string, opts:lspconfig.Config):boolean?>
                setup = {
                    -- example to setup with typescript.nvim
                    -- tsserver = function(_, opts)
                    --   require("typescript").setup({ server = opts })
                    --   return true
                    -- end,
                    -- Specify * to use this function as a fallback for any server
                    -- ["*"] = function(server, opts) end,
                },
            }
        end,
        config = function(_, opts)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = require("plugins.lsp.keymaps").on_attach,
            })

            local servers = opts.servers

            -- Auto complete
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
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
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(
                    require("mason-lspconfig.mappings.server").lspconfig_to_package
                )
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    if server_opts.enabled ~= false then
                        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        if
                            server_opts.mason == false
                            or not vim.tbl_contains(all_mslp_servers, server)
                        then
                            setup(server)
                        else
                            ensure_installed[#ensure_installed + 1] = server
                        end
                    end
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
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",

                "codespell",

                "html-lsp",
                "prettier",

                "proselint",
                "taplo",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
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

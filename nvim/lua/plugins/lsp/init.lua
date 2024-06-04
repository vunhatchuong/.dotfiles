-- https://mason-registry.dev/registry/list
return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        init = function()
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = "rounded" }
            )
            require("lspconfig.ui.windows").default_options.border = "rounded"
        end,
        opts = function()
            local icons = require("core.icons")
            return {
                -- options for vim.diagnostic.config()
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "icons",
                        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                        -- prefix = "icons",
                        float = {
                            border = "rounded",
                        },
                    },
                    severity_sort = true,
                    signs = {
                        text = {
                            [vim.diagnostic.severity.ERROR] = icons.diagnostics.BoldError,
                            [vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
                            [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
                            [vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
                        },
                    },
                },
                inlay_hints = {
                    enabled = true,
                    exclude = {}, -- filetypes for which you don't want to enable inlay hints
                },
                -- https://github.com/neovim/neovim/issues/29156
                codelens = {
                    enabled = false,
                },
                -- Enable lsp cursor word highlighting
                document_highlight = {
                    enabled = true,
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
                -- LSP Server Settings
                ---@type lspconfig.options
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
                ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
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
            local on_supports_method = function(method, fn)
                return vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local client =
                            vim.lsp.get_client_by_id(args.data.client_id)
                        if client and client.supports_method(method) then
                            return fn(client, args.buf)
                        end
                    end,
                })
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = require("plugins.lsp.keymaps").on_attach,
            })

            -- inlay hints
            if opts.inlay_hints.enabled then
                on_supports_method(
                    "textDocument/inlayHint",
                    function(client, buffer)
                        if
                            vim.api.nvim_buf_is_valid(buffer)
                            and vim.bo[buffer].buftype == ""
                            and not vim.tbl_contains(
                                opts.inlay_hints.exclude,
                                vim.bo[buffer].filetype
                            )
                        then
                            local ih = vim.lsp.inlay_hint
                            if ih.enable then
                                ih.enable(true, { bufnr = buffer })
                            end
                        end
                    end
                )
            end

            -- code lens
            if opts.codelens.enabled and vim.lsp.codelens then
                on_supports_method(
                    "textDocument/codeLens",
                    function(client, buffer)
                        vim.lsp.codelens.refresh()
                        vim.api.nvim_create_autocmd(
                            { "BufEnter", "CursorHold", "InsertLeave" },
                            {
                                buffer = buffer,
                                callback = vim.lsp.codelens.refresh,
                            }
                        )
                    end
                )
            end

            if
                type(opts.diagnostics.virtual_text) == "table"
                and opts.diagnostics.virtual_text.prefix == "icons"
            then
                opts.diagnostics.virtual_text.prefix = function(diagnostic)
                    local icons = require("core.icons")
                    for d, icon in pairs(icons.diagnostics) do
                        if
                            diagnostic.severity
                            == vim.diagnostic.severity[d:upper()]
                        then
                            return icon
                        end
                    end
                end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

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
                "lua-language-server",
                "stylua",
                "codespell",

                "html-lsp",
                "prettier",

                "marksman",
                "markdownlint-cli2",
                "proselint",
                "json-lsp",
                "yaml-language-server",
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
}

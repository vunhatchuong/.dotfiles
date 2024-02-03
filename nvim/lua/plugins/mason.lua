-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/lazy-loading-with-lazy-nvim.md
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
            { "folke/neodev.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions

                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set(
                        "n",
                        keys,
                        func,
                        { buffer = bufnr, desc = desc }
                    )
                end

                nmap("<leader>i", "<cmd>LspInfo<cr>", "Lsp Info")
                nmap("<leader>I", "<cmd>LspInstall<cr>", "Lsp Install")
                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap(
                    "<C-k>",
                    vim.diagnostic.open_float,
                    "Open floating diagnostic message")
                nmap(
                    "gd",
                    require("telescope.builtin").lsp_definitions,
                    "[G]oto [D]efinition")
                nmap(
                    "gr",
                    require("telescope.builtin").lsp_references,
                    "[G]oto [R]eferences")
                nmap(
                    "gi",
                    require("telescope.builtin").lsp_implementations,
                    "[G]oto [I]mplementation")
                nmap(
                    "<leader>D",
                    require("telescope.builtin").lsp_type_definitions,
                    "Type [D]efinition")
                nmap("gD",
                    vim.lsp.buf.declaration,
                    "[G]oto [D]eclaration")
                nmap(
                    "<leader>ds",
                    require("telescope.builtin").lsp_document_symbols,
                    "[D]ocument [S]ymbols")
                nmap(
                    "<leader>ws",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[W]orkspace [S]ymbols")
                -- nmap(
                --     "<leader>sd",
                --     require("telescope.builtin").diagnostics,
                --     "[S]earch [D]iagnostics")
            end)

            local opts = {
                ensure_installed = {
                    "gopls",
                    "gofumpt",
                    "goimports-reviser",
                    "golines",
                    "gomodifytags",
                    "gotests",
                    "impl",
                    "templ",
                    "golangci-lint",
                    "prettierd",
                    "html-lsp",
                    "json-lsp",
                    "lua-language-server",
                    "powershell-editor-services",
                },
                registries = {
                    "github:mason-org/mason-registry",
                },
            }
            require("neodev").setup({})
            require("mason-lspconfig").setup({
                opts,
                handlers = {
                    lsp_zero.default_setup,
                },

            })
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}

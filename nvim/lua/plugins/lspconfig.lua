-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local Plugin = { "neovim/nvim-lspconfig" }
local user = {}

Plugin.event = { "BufReadPost", "BufNewFile", "BufWritePre" }
Plugin.cmd = { "LspInfo", "LspInstall", "LspStart" }
Plugin.dependencies = {
    {
        "folke/neodev.nvim",
        opts = {
            library = { plugins = { "nvim-dap-ui" }, types = true },
        },
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
}

function Plugin.init()
    local icons = require("core.icons")
    local sign = function(opts)
        -- See :help sign_define()
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
        -- See :help vim.diagnostic.config()
        vim.diagnostic.config({
            underline = true,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
                -- Set to a function that returns the diagnostics icon based on the severity
                -- Only works on a recent 0.10.0 build.
                -- prefix = "icons",
            },
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
            },
        })
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
        )
        require("lspconfig.ui.windows").default_options.border = "rounded"
    end

    sign({ name = "DiagnosticSignError", text = icons.diagnostics.BoldError })
    sign({ name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning })
    sign({ name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint })
    sign({
        name = "DiagnosticSignInfo",
        text = icons.diagnostics.BoldInformation,
    })
end

function Plugin.config()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        desc = "LSP actions",
        callback = user.on_attach,
    })

    -- Auto complete
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
            require("plugins.lang.general.lua")
        end,
        ["jsonls"] = function()
            require("plugins.lang.general.json")
        end,
        ["yamlls"] = function()
            require("plugins.lang.general.yaml")
        end,
    })
end

function user.on_attach()
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = true, desc = desc })
    end

    -- stylua: ignore start
    nmap("<leader>i", "<cmd>LspInfo<cr>", "Info")
    nmap("<leader>I", "<cmd>LspInstall<cr>", "Install")
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.diagnostic.open_float, "Open floating diagnostic message")
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    -- nmap("<leader>sd", require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics")
end

-- stylua: ignore end

return Plugin

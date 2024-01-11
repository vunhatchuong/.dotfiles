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

                nmap(
                    "gd",
                    require("telescope.builtin").lsp_definitions,
                    "[G]oto [D]efinition"
                )
                nmap(
                    "gr",
                    require("telescope.builtin").lsp_references,
                    "[G]oto [R]eferences"
                )
                nmap(
                    "gI",
                    require("telescope.builtin").lsp_implementations,
                    "[G]oto [I]mplementation"
                )
                nmap(
                    "<leader>D",
                    require("telescope.builtin").lsp_type_definitions,
                    "Type [D]efinition"
                )
                nmap(
                    "<leader>ds",
                    require("telescope.builtin").lsp_document_symbols,
                    "[D]ocument [S]ymbols"
                )
                nmap(
                    "<leader>ws",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[W]orkspace [S]ymbols"
                )
                --nmap('<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')

                -- See `:help K` for why this keymap
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap(
                    "<C-k>",
                    vim.lsp.buf.signature_help,
                    "Signature Documentation"
                )
                nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                --[[ keymap(bufnr, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts) ]]
            end)

            require("neodev").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end,
    },
}

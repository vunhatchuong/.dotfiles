local M = {}

function M.on_attach()
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = true, desc = desc })
    end

    -- stylua: ignore start
    -- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

    -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.diagnostic.open_float, "Open floating diagnostic message")

    -- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]definition")
    -- nmap("gr", ":Lspsaga finder<CR>", "[G]oto [R]eferences")
    -- nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

    nmap("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]definition")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    nmap("<leader>ws", function()
        require("fzf-lua").lsp_live_workspace_symbols({
            regex_filter = Util.finder.symbols_filter,
        })
    end, "[W]orkspace [S]symbols")

    -- nmap("<leader>sd", require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics")

    -- nmap("<leader>cc", vim.lsp.codelens.run, "Run Codelens")
    -- nmap("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
    -- stylua: ignore end
end

function M.workspace_diagnostics(client, bufnr)
    require("workspace-diagnostics").populate_workspace_diagnostics(
        client,
        bufnr
    )
end

return M

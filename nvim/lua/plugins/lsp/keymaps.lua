local M = {}

-- stylua: ignore
M._keys = {
    -- { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },

    -- { "K", vim.lsp.buf.hover, desc = "Hover Doc" },
    { "<C-k>", vim.diagnostic.open_float, desc = "Diagnostic Help" },

    -- { "gd", require("telescope.builtin").lsp_definitions, desc = "[G]oto [D]definition" },
    -- { "gr", ":Lspsaga finder<CR>", desc = "[G]oto [R]eferences" },
    -- { "gi", require("telescope.builtin").lsp_implementations, desc = "[G]oto [I]mplementation" },

    -- { "gt", require("telescope.builtin").lsp_type_definitions, desc = "Type [D]definition" },
    { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },

    {
        "<leader>ws",
        function()
            require("fzf-lua").lsp_live_workspace_symbols({
                regex_filter = Util.finder.symbols_filter,
            })
        end,
        desc = "[W]orkspace [S]symbols",
    },

    -- { "<leader>sd", require("telescope.builtin").diagnostics, desc = "[S]earch [D]iagnostics" },

    -- { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens" },
    -- { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens" },
}

function M.on_attach(_, buffer)
    local opts = { noremap = true, silent = true, buffer = buffer }

    for _, keys in pairs(M._keys) do
        vim.keymap.set(
            keys.mode or "n",
            keys[1],
            keys[2],
            vim.tbl_extend("force", opts, { desc = "LSP: " .. keys.desc })
        )
    end
end

return M

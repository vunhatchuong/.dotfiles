local M = {}

local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

-- stylua: ignore
M._keys = {
    -- { "<leader>rn", vim.lsp.buf.rename, desc = "[R]e[n]ame" },

    -- { "K", vim.lsp.buf.hover, desc = "Hover Doc" },
    { "<C-k>", vim.diagnostic.open_float, desc = "Diagnostic Help" },

    -- { "gd", require("telescope.builtin").lsp_definitions, desc = "[G]oto [D]definition" },
    -- { "gr", "<CMD>Lspsaga finder<CR>", desc = "[G]oto [R]eferences" },
    { "gi", "<CMD>FzfLua lsp_implementations", desc = "[G]oto [I]mplementation" },

    { "gt", "<CMD>FzfLua lsp_typedefs", desc = "[T]ype Ddefinition" },
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

    { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
    { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
    { "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
    { "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
    { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
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

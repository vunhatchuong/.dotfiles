require("hover").register({
    name = "LSPSaga Hover Doc",
    priority = 1000,
    enabled = function(bufnr)
        local has_lspsaga, _ = pcall(require, "lspsaga")
        if not has_lspsaga then
            return false
        end

        for _, client in pairs(vim.lsp.get_clients()) do
            if client:supports_method("textDocument/hover", bufnr) then
                return true
            end
        end
        return false
    end,
    execute = function()
        vim.cmd("Lspsaga hover_doc")
    end,
})

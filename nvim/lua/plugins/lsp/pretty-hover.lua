require("hover").register({
    name = "Pretty Hover Doc",
    priority = 1000,
    enabled = function(bufnr)
        local has_hover, _ = pcall(require, "pretty_hover")
        if not has_hover then
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
        require("pretty_hover").hover()
    end,
})

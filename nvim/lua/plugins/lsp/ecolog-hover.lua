local get_clients = vim.lsp.get_active_clients

require("hover").register({
    name = "Ecolog Saga Hover",
    priority = 1000,
    enabled = function(bufnr)
        for _, client in pairs(get_clients()) do
            if
                client.supports_method("textDocument/hover", { bufnr = bufnr })
            then
                return true
            end
        end
        return false
    end,
    execute = function()
        vim.cmd("EcologSagaHover")
    end,
})

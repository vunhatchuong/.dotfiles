local lspconfig = require("lspconfig")

lspconfig.jsonls.setup({
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
        },
    },
})

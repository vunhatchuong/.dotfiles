return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        lazy = false,
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",

                "html-lsp",
                "prettier",

                "marksman",
                "json-lsp",
                "yaml-language-server",
                "taplo",
            },
            registries = {
                "github:mason-org/mason-registry",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
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

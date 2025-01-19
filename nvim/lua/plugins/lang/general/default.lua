return {
    Util.tool_installer.ensure_installed({
        treesitter = {
            "lua",
            "luadoc",
            "luap",
            "bash",
            "vimdoc",
            "diff",
            "html",
            "http",
            "gitignore",
            "query",
            "toml",
            "xml",
            "regex",
        },
        mason = {
            "lua-language-server",
            "stylua",
            "shfmt",

            "typos-lsp", -- code spellchecker

            "html-lsp",
            "prettier",

            "taplo",
        },
    }),
}

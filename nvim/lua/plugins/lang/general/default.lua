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
            "markdown",
            "markdown_inline",
            "query",
            "json",
            "jsonc",
            "yaml",
            "toml",
            "xml",
            "regex",
        },
        mason = {
            "lua-language-server",
            "stylua",
            "shfmt",

            "typos-lsp", -- code spellchecker
            -- "ltex-ls-plus", -- natural language linter

            "html-lsp",
            "prettier",

            "taplo",
        },
    }),
}

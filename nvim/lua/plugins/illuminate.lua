return {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
        filetypes_denylist = {
            "netrw",
            "lazy",
            "mason",
            "oil",
            "Trouble",
            "harpoon",
            "TelescopePrompt",
            "spectre_panel",
            "undotree",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
    end,
}

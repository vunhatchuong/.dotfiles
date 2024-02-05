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
            "mason",
            "harpoon",
            "lazy",
            "Trouble",
            "TelescopePrompt",
            "oil",
            "spectre_panel",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
    end,
}

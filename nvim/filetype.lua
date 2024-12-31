vim.filetype.add({
    extension = {
        conf = "toml",
        -- h = "c",
    },
    filename = {
        ["setup.cfg"] = "toml",
    },
    pattern = {
        -- [".*"] = {
        --     function(_, bufnr)
        --         return "tcl"
        --     end,
        -- },
    },
})

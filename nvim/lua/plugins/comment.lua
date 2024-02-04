return {
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = "",
                -- Toggle comment on current line
                comment_line = "<C-_>",
                -- Toggle comment on visual selection
                comment_visual = "<C-_>",
                textobject = "",
            },
        },
    },
}

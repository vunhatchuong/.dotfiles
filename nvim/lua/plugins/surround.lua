return {
    "echasnovski/mini.surround",
    keys = {
        { "sa", desc = "Add surround" },
        { "sd", desc = "Delete surround" },
        { "sr", desc = "Replace surrounding" },
    },
    opts = {
        search_method = "cover_or_next",
        mappings = {
            find = "", -- Find surrounding (to the right)
            find_left = "", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            update_n_lines = "", -- Update `n_lines`
        },
    },
}

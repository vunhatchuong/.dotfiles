return {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
        require("Comment").setup({
            toggler = {
                ---Line-comment toggle keymap
                line = "<C-_>",

                block = "false",
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = "false",

                block = "<C-_>",
            },
            mappings = {
                basic = "true",
                extra = "false",
            },
        })
    end,
}

return {
    { -- nested neovim instances open in the parent
        "willothy/flatten.nvim",
        lazy = false,
        priority = 1001,
        opts = {
            window = { open = "smart" },
        },
    },
    { -- edit terminal in normal mode
        "chomosuke/term-edit.nvim",
        event = "TermOpen",
        version = "1.*",
        opts = {
            prompt_end = "~> ",
        },
    },
}

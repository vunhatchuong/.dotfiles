return {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew",
        highlight = {
            ui = "String",
            search = "@text.note",
            replace = "@text.danger",
        },
    },
    keys = {
        {
            "<leader>sr",
            function()
                require("spectre").open()
            end,
            desc = "Replace in files (Spectre)",
        },
    },
}

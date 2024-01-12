return {
    "SmiteshP/nvim-navic",
    config = function()
        require("nvim-navic").setup({
            highlight = true,
            icons = require("core.icons").kind,
            lsp = {
                auto_attach = true,
            },
            click = true,
            separator = " " .. require("core.icons").ui.ChevronRight .. " ",
            depth_limit = 0,
            depth_limit_indicator = "..",
        })
    end,
}

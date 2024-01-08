return {
    -- ys Add desired surround around text defined by <motion>
    -- ds <existing> Delete existing surround
    -- cs <existing> <desired> Change existing surround to desired
    "kylechui/nvim-surround",
    --[[ version = "*", -- Use for stability; omit to use `main` branch for the latest features ]]
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
        })
    end
}


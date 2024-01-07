return {
    "andymass/vim-matchup",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
}


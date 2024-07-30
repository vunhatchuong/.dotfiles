local theme = {
    foreground = "#868690",
    background = "#0F1014",
    cursor_bg = "#7C829D",
    cursor_fg = "#868690",
    cursor_border = "#7C829D",
    selection_fg = "#93939c",
    selection_bg = "#22222a",

    ansi = { "#131317", "#999EB2", "#626983", "#D3D5DE", "#7C829D", "#E2E4ED", "#B6BAC8", "#868690" },
    brights = { "#575861", "#999EB2", "#626983", "#D3D5DE", "#7C829D", "#E2E4ED", "#B6BAC8", "#868690" },
}
theme.tab_bar = {
    background = "rgba(16, 16, 20, 0.9)",
    new_tab = { fg_color = theme.background, bg_color = theme.brights[6] },
    new_tab_hover = { fg_color = theme.background, bg_color = theme.foreground },
}

return theme

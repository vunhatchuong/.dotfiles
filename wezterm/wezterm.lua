---  CORE   ---
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

---  SYSTEM   ---
-- config.color_scheme = "Sequoia Monochrome"
--config.color_scheme = "Sequoia Moonlight"
config.colors = require("themes.sequoia-monochrome")

config.font = wezterm.font_with_fallback({
    {
        family = "JetBrainsMono NF",
        weight = "Medium",
    },
    {
        family = "JetBrainsMono Nerd Font",
        weight = "Medium",
    },
})
config.font_size = 15
config.window_background_opacity = 0.9
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
    left = 8,
    right = 8,
}

---  OS SPECIFIC   ---
if is_windows then
    config.default_prog = { "pwsh.exe", "-NoLogo" }
    -- config.default_domain = "WSL:Arch"
    config.default_cwd = "D:/"
    config.win32_system_backdrop = "Acrylic"
end

config.launch_menu = {
    {
        label = "Powershell",
        args = { "pwsh.exe", "-NoLogo" },
    },
    {
        label = "Powershell(Admin)",
        args = { "sudo", "pwsh.exe", "-NoLogo" },
    },
    {
        label = "wsl",
        args = { "wsl.exe", "--cd", "~" },
    },
}

---  TAB   ---
-- config.enable_tab_bar = false
config.initial_rows = 45
config.initial_cols = 160
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.keys = {
    { key = "w", mods = "CTRL", action = act.CloseCurrentTab({ confirm = false }) },
    {
        key = "p",
        mods = "CTRL",
        action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS" }),
    },
}

-- require("tmux").apply(config)
require("bar").apply(config)

return config

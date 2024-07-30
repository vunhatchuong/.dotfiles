---  CORE   ---
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local sessionizer = require("sessionizer")

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
        cwd = "~",
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
config.window_decorations = "NONE"

---  LEADER   ---
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
    { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "o", mods = "CTRL" }) },
    -- Client navigation --
    { key = "l", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
    { key = "h", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },

    -- PANE --
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- TAB --
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },

    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
    { key = "h", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },

    { key = "n", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
    { key = "p", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },

    { key = "s", mods = "LEADER", action = act.ShowTabNavigator },
    { key = "i", mods = "LEADER", action = act.ActivateCopyMode },

    {
        key = ",",
        mods = "LEADER",
        action = wezterm.action.PromptInputLine({
            description = "Tab name",
            action = wezterm.action_callback(function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
    {
        key = "f",
        mods = "LEADER",
        action = wezterm.action_callback(sessionizer.open),
    },
    {
        key = "e",
        mods = "LEADER",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    {
        key = "p",
        mods = "CTRL",
        action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS" }),
    },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end

require("bar").apply(config)

return config

---  CORE   ---
local wezterm = require("wezterm")
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
local mux = wezterm.mux
local act = wezterm.action

-- wezterm.on("gui-attached", function(domain)
--     -- maximize all displayed windows on startup
--     local workspace = mux.get_active_workspace()
--     for _, window in ipairs(mux.all_windows()) do
--         if window:get_workspace() == workspace then
--             window:gui_window():maximize()
--         end
--     end
-- end)

local config = wezterm.config_builder()

---  SYSTEM   ---
config.max_fps = 144
config.animation_fps = 60
config.color_scheme = "Catppuccin Mocha"
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

---  OS SPECIFIC   ---
if is_windows then
    config.default_prog = { "pwsh.exe", "-NoLogo" }
    config.default_cwd = "D:/"
    config.win32_system_backdrop = "Acrylic"
end

config.launch_menu = {
    {
        label = "pwsh",
        args = { "pwsh.exe", "-NoLogo" },
        cwd = "~",
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
    -- PANE --
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- TAB --
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },
    { key = "s", mods = "LEADER", action = act.ShowTabNavigator },
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "j", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },
    { key = "k", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
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
        key = "p",
        mods = "CTRL",
        action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS" }),
    },
}

return config

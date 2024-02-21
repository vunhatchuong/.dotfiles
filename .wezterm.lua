---  CORE   ---
local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-attached", function(domain)
    -- maximize all displayed windows on startup
    local workspace = mux.get_active_workspace()
    for _, window in ipairs(mux.all_windows()) do
        if window:get_workspace() == workspace then
            window:gui_window():maximize()
        end
    end
end)

local config = wezterm.config_builder()

---  SYSTEM   ---
config.max_fps = 120
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono NF", { weight = "Medium" })
config.font_size = 15
config.window_background_opacity = 0.9
config.scrollback_lines = 5000

---  OS SPECIFIC   ---
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- config.default_domain = "WSL:Ubuntu"
    config.default_prog = { "pwsh.exe", "-NoLogo" }
    config.default_cwd = "D:/"
end

---  TAB   ---
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config

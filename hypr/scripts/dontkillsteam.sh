# http://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#minimize-steam-instead-of-killing
if [[ $(hyprctl activewindow -j | jq -r ".class") == "Steam" ]]; then
    xdotool windowunmap $(xdotool getactivewindow)
else
    hyprctl dispatch killactive ""
fi

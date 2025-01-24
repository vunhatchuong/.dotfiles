$wingetDeps = @(
    "Microsoft.Powershell.Preview"
)

$scoopGeneral = @(
    "main/git"

    "nerd-fonts/JetBrainsMono-NF"
    "extras/winrar"

    "extras/firefox"
    "extras/googlechrome"

    "extras/obsidian"
    "extras/discord"
    "extras/notepadplusplus"
    "extras/flameshot"

    "games/steam"
    "games/epic-games-launcher"

    "main/neovim"
    "smain/win32yank" # For nvim wsl
    "extras/lazygit"
    "extras/psfzf"

    "main/gsudo" # Can be replaced with builtin sudo: https://github.com/scottmckendry/Windots/commit/cf3af128e06334011fb1840dff682b63a497eaf7
    "extras/vlc"
    "extra/wiztree"
    "extras/revouninstaller"
    "extras/bleachbit"
    "extras/transmission"
    "extras/everything-lite"
)

$psModules = @(
    "PSFzf"
)

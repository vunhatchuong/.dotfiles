$wingetDeps = @(
    "Microsoft.Powershell.Preview"
)

$scoopGeneral = @(
    "main/git"

    "extras/winrar"
    "main/7zip"

    "nerd-fonts/JetBrainsMono-NF"
    "nerd-fonts/Maple-Mono-NF"

    # --------------------------------------------------- // CLI
    "main/gsudo" # Can be replaced with builtin sudo: https://github.com/scottmckendry/Windots/commit/cf3af128e06334011fb1840dff682b63a497eaf7
    "main/neovim"
    "smain/win32yank" # For nvim wsl
    "extras/lazygit"
    "extras/psfzf"

    # --------------------------------------------------- // Applications
    # ------------------------- // Windows specific
    "extras/everything-lite"
    "extras/vlc"
    "extra/wiztree"
    "extras/revouninstaller"
    "extras/firefox"
    "extras/googlechrome"
    "extras/gimp"
    "extras/notepadplusplus"
    # -------------------------

    "extras/flameshot"
    "extras/discord"
    "extras/bleachbit"
    "extras/transmission" # Bittorrent client
    "extras/obsidian"
    "extras/sioyek" # PDF reader

    # --------------------------------------------------- // Devs
    #"extras/vscode"
    #"extras/idea"
    #"extras/yaak" Not available yet

    # --------------------------------------------------- // Entertainment
    "games/steam"
    "games/epic-games-launcher"
)

$psModules = @(
    "PSFzf"
)

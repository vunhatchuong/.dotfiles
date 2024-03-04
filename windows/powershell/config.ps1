# $PROFILE for profile location, put this file in $env:USERPROFILE\.config\powershell\

# Modules
Import-Module PSFzf

# Prevent conflict with built-in aliases
Remove-Alias gc -Force -ErrorAction SilentlyContinue
Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gcm -Force -ErrorAction SilentlyContinue
Remove-Alias gcs -Force -ErrorAction SilentlyContinue
Remove-Alias gl -Force -ErrorAction SilentlyContinue
Remove-Alias gm -Force -ErrorAction SilentlyContinue
Remove-Alias gp -Force -ErrorAction SilentlyContinue
Remove-Alias gpv -Force -ErrorAction SilentlyContinue
Remove-Alias ls -Force -ErrorAction SilentlyContinue
Remove-Alias cat -Force -ErrorAction SilentlyContinue
Remove-Alias tree -Force -ErrorAction SilentlyContinue

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Set environment variables
$ENV:EDITOR = "nvim"
$ENV:SHELL = "pwsh -NoLogo"
$Env:CONFIG_DIR = "$env:USERPROFILE\.config\lazygit"

#----------------------------------

Set-PSReadLineOption -EditMode Windows
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadLineKeyHandler -Key Tab -Function Complete #<Tab><Tab> to show possible matches
Set-PSReadLineOption -MaximumHistoryCount 1000
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

#----------------------------------

# Utilities
## which command
function which ($command)
{
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function bashAlias([string]$name, [string]$command)
{
    $sb = [scriptblock]::Create($command)
    New-Item "Function:\global:$name" -Value $sb | Out-Null
}

#Alias
bashAlias grep "findstr @args"
bashAlias tig "C:\Program Files\Git\usr\bin\tig.exe @args"
bashAlias less "C:\Program Files\Git\usr\bin\less.exe @args"
bashAlias touch "New-Item @args"

bashAlias ls "eza --color=always --icons --time-style=long-iso @args"
bashAlias ll "eza --color=always --icons --time-style=long-iso -la --header @args"
bashAlias la "eza --color=always --icons --time-style=long-iso -a @args"
bashAlias tree "eza --tree --level=2 --group-directories-first"

bashAlias lg "lazygit @args"
bashAlias lzd "lazydocker @args"
bashAlias cz "chezmoi @args"

bashAlias cat "bat @args"
bashAlias vim "nvim @args"
bashAlias god "go mod @args"

bashAlias ... "cd ../../"
bashAlias .... "cd ../../../"
bashAlias ..... "cd ../../../../"

# Git alias
bashAlias gr "git remote @args"
bashAlias gra "git remote add @args"
bashAlias grset "git remote set-url @args"
bashAlias grv "git remote -v @args"

bashAlias gst "git status @args"
bashAlias ga "git add @args"
bashAlias gaa "git add --all"

bashAlias gcam "git commit -a -m @args"
bashAlias gcmsg "git commit -m @args"

bashAlias gl "git pull @args"
bashAlias gm "git merge @args"

bashAlias gb "git branch @args"
bashAlias gba "git branch -a"

bashAlias gc "git clone @args"
bashAlias gco "git checkout @args"
bashAlias gcb "git checkout -b @args"

bashAlias gd "git diff @args"

bashAlias gp "git push @args"
bashAlias gpd "git push --dry-run @args"

bashAlias glo "git log --oneline --decorate"
bashAlias glog "git log --oneline --decorate --graph"


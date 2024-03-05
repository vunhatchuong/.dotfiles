# $PROFILE for profile location, put this file in $env:USERPROFILE\.config\powershell\

# Modules
Import-Module PSFzf

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Set environment variables
$ENV:EDITOR = "nvim"
$ENV:SHELL = "pwsh -NoLogo"
$Env:CONFIG_DIR = "$env:USERPROFILE\.config\lazygit"

#----------------------------------

Set-PSReadLineOption -EditMode Windows
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit
# Set-PSReadLineKeyHandler -Key Tab -Function Complete #<Tab><Tab> to show possible matches
Set-PSReadLineOption -MaximumHistoryCount 1000
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

#----------------------------------

. "$PSScriptRoot/alias.ps1"
. "$PSScriptRoot/git.ps1"
. "$PSScriptRoot/conda.ps1"
. "$PSScriptRoot/export.ps1"

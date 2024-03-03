# $PROFILE for profile location, put this file in $env:USERPROFILE\.config\powershell\

# Prevent conflict with built-in aliases
Remove-Alias gc -Force -ErrorAction SilentlyContinue
Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gcm -Force -ErrorAction SilentlyContinue
Remove-Alias gcs -Force -ErrorAction SilentlyContinue
Remove-Alias gl -Force -ErrorAction SilentlyContinue
Remove-Alias gm -Force -ErrorAction SilentlyContinue
Remove-Alias gp -Force -ErrorAction SilentlyContinue
Remove-Alias gpv -Force -ErrorAction SilentlyContinue

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

#----------------------------------

#Alias
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias touch New-Item
Set-Alias lg lazygit
Set-Alias cz chezmoi
Remove-Alias ls

#----------------------------------

# Utilities
## which command
function which ($command)
{
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

## View hidden files
function lsa()
{
    Get-ChildItem -Hidden
}

function ls
{
    Get-ChildItem | format-wide -autosize
}

function gst
{
    git status $args
}

function ga
{
    git add $args
}

function gb
{
    git branch $args
}

function gl
{
    git pull $args
}

function gp
{
    git push $args
}

function gcmsg
{
    git commit -m $args
}

function grv
{
    git remote -v $args
}

function gd
{
    git diff $args
}

function gco
{
    git checkout $args
}

function gm
{
    git merge $args
}

function glo
{
    git log --oneline --decorate
}

function glog
{
    git log --oneline --decorate --graph
}


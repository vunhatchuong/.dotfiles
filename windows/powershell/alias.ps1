function bashAlias([string]$name, [string]$command)
{
    $sb = [scriptblock]::Create($command)
    New-Item "Function:\global:$name" -Value $sb | Out-Null
}

function which ($command)
{
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Prevent conflict with built-in aliases
#Remove-Alias ls -Force -ErrorAction SilentlyContinue
#Remove-Alias cat -Force -ErrorAction SilentlyContinue
#Remove-Alias tree -Force -ErrorAction SilentlyContinue

bashAlias grep "findstr @args"
bashAlias tig "C:\Program Files\Git\usr\bin\tig.exe @args"
bashAlias less "C:\Program Files\Git\usr\bin\less.exe @args"
bashAlias touch "New-Item @args"

#bashAlias ls "eza --color=always --icons --time-style=long-iso @args"
#bashAlias ll "eza --color=always --icons --time-style=long-iso -la --header @args"
#bashAlias la "eza --color=always --icons --time-style=long-iso -a @args"
#bashAlias tree "eza --tree --level=2 --group-directories-first"

bashAlias lg "lazygit @args"
bashAlias lzd "lazydocker @args"

#bashAlias cat "bat @args"
#bashAlias vim "nvim @args"
#bashAlias god "go mod @args"

bashAlias ... "cd ../../"
bashAlias .... "cd ../../../"
bashAlias ..... "cd ../../../../"

. "$env:USERPROFILE\.config\powershell\config.ps1"

if (Test-Path "C:\Users\ronny\AppData\Local\micromamba\micromamba.exe")
{
    $Env:MAMBA_ROOT_PREFIX = "C:\Users\ronny\micromamba"
    $Env:MAMBA_EXE = "C:\Users\ronny\AppData\Local\micromamba\micromamba.exe"
    (& $Env:MAMBA_EXE 'shell' 'hook' -s 'powershell' -p $Env:MAMBA_ROOT_PREFIX) | Out-String | Invoke-Expression

    bashAlias mamba "micromamba @args"
} elseif (Test-Path "C:\Users\ronny\miniconda3\Scripts\conda.exe")
{
    (& "C:\Users\ronny\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { $hook = if ($PSVersionTable.PSVersion.Major -ge 6)
        { 'pwd'
        } else
        { 'prompt'
        } (zoxide init powershell --hook $hook | Out-String) })
fnm env --use-on-cd | Out-String | Invoke-Expression

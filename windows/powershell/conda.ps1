if (Test-Path "$HOME\AppData\Local\micromamba\micromamba.exe")
{
    $Env:MAMBA_ROOT_PREFIX = "$HOME\micromamba"
    $Env:MAMBA_EXE = "$HOME\AppData\Local\micromamba\micromamba.exe"
    (& $Env:MAMBA_EXE 'shell' 'hook' -s 'powershell' -p $Env:MAMBA_ROOT_PREFIX) | Out-String | Invoke-Expression

    bashAlias mamba "micromamba @args"
} elseif (Test-Path "$HOME\miniconda3\Scripts\conda.exe")
{
    (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

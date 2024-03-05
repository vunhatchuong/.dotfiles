Invoke-Expression (&starship init powershell)
Invoke-Expression (& { $hook = if ($PSVersionTable.PSVersion.Major -ge 6)
        { 'pwd'
        } else
        { 'prompt'
        } (zoxide init powershell --hook $hook | Out-String) })
fnm env --use-on-cd | Out-String | Invoke-Expression

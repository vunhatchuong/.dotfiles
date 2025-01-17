# Windows is shit: https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement#standard-user
function SSH-CopyId {
    param (
        [string]$PublicKey = "id_rsa.pub",
        [string]$User,
        [string]$Host
    )

    if (!(Test-Path $PublicKey)) {
        $PublicKeyPath = Join-Path -Path "$env:USERPROFILE\.ssh" -ChildPath $PublicKey
    } else {
        $PublicKeyPath = $PublicKey
    }

    if (-not (Test-Path -Path $PublicKeyPath)) {
        Write-Error "Public key file not found at '$PublicKeyPath'. Please generate one or specify the correct key file name or path."
        return
    }

    $publicKey = Get-Content -Path $PublicKeyPath -Raw

    $remoteCommand = @"
mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$publicKey' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
"@

    $sshCommand = "ssh $User@$Host $remoteCommand"
    Write-Host "Copying SSH public key to $User@$Host..."
    Invoke-Expression $sshCommand

    Write-Host "Public key successfully copied to $User@$Host."
}

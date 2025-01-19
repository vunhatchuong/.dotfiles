. ./packages.ps1

function main()
{
    Clear-Host
    ShowMainMenu
}

function ShowMainMenu()
{
    Write-Host @"
+===============================================+
|                   MAIN MENU                   |
+===============================================+
|                                               |
|    1) Winget Package Installer                |
|    2) Scoop Package Installer                 |
|    3) Powershell Module Installer             |
|    4) Custom Package Installer                |
|    0) EXIT                                    |
+===============================================+

"@

    $userChoice = Read-Host "OPTION"

    switch ($userChoice)
    {
        1 { InstallWithWinget }
        2 { InstallWithScoop }
        3 { InstallWithPwshModules }
        4 { InstallWithCustom }
        0 { Write-Host "Exiting"; exit 0 }
        default {
            Write-Host "Option not available"
            Start-Sleep -Seconds 2
            ShowMainMenu
        }
    }
}

function InstallWithWinget()
{
    Clear-Host
    InstallPackages "winget" $wingetDeps
}

function InstallWithScoop()
{
    Clear-Host

    Write-Host "Checking if Scoop exists..."
    if ($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue))
    {
        Write-Output "Scoop doesn't exist, installing Scoop and Git."
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        scoop install git
    }
    else
    {
        Write-Output "Scoop exists, updating Scoop."
        & scoop update *
        & scoop install git
    }

    Write-Host "Adding Scoop buckets"
    & scoop bucket add extras
    & scoop bucket add nerd-fonts

    Write-Host "Installing general Scoop packages..."
    InstallPackages "scoop" $scoopGeneral
}

function InstallWithPwshModules()
{
    Clear-Host
    InstallPackages "pwsh" $psModules
    Write-Host "Finishes, returning to menu..."
    Start-Sleep -Seconds 2
    ShowMainMenu
}

function InstallWithCustom()
{
    Clear-Host
    if (-not (CheckInstalled "micromamba"))
    {
        Write-Host "Installing micromamba..."
        Invoke-Expression ((Invoke-WebRequest -Uri https://micro.mamba.pm/install.ps1).Content)
    }
    Write-Host "Finishes, returning to menu..."
    Start-Sleep -Seconds 2
    ShowMainMenu
}

function InstallPackages($installerType, $packages)
{
    $installCMD = ""
    $installedPackages = ""

    switch ($installerType)
    {
        "winget" {
            $installCMD = "winget install --id"
        }
        "scoop" {
            $installCMD = "scoop install"
            $installedPackages = scoop list | Out-String
            Write-Host $installedPackages
        }
        "pwsh" {
            $installCMD = "Install-Module -Name"
            $installedPackages = Get-Module | Out-String
            Write-Host $installedPackages
        }
        default {
            Write-Host "Unsupported installer type: $installerType"
            return
        }
    }

    Write-Host "Already installed packages $installedPackages"
    Write-Host "Installing missing $installerType dependencies..."

    foreach ($package in $packages)
    {
        if ($installedPackages -notmatch $package)
        {
            Write-Output "Installing missing dependency $package"
            Invoke-Expression "$installCMD $package"
        }
    }

    Write-Host "Finishes, returning to menu..."
    Start-Sleep -Seconds 2
    ShowMainMenu
}

function CheckInstalled
{
    param (
        [string]$CommandName
    )

    if (Get-Command $CommandName -ErrorAction SilentlyContinue)
    {
        Write-Host "$CommandName is installed."
        return $true
    }
    else
    {
        Write-Host "$CommandName is not installed."
        return $false
    }
}

# Start the main function
main

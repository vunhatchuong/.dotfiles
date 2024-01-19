# Load external script
. ./packages.ps1

# Check if 'SCOOP' is installed
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
|    0) EXIT                                    |
+===============================================+

"@

    $userChoice = Read-Host "OPTION"

    switch ($userChoice)
    {
        1
        { InstallWithWinget
        }
        2
        { InstallWithScoop
        }
        0
        { Write-Host "Exiting"; exit 0
        }
        default
        {
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
        Start-Sleep -Seconds 1
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        scoop install git
    } else
    {
        Write-Output "Scoop exists, updating Scoop."
        Start-Sleep -Seconds 1
        & scoop install git
        & scoop update *
    }

    Start-Sleep -Seconds 1
    Write-Host "Adding Scoop buckets"
    & scoop bucket add extras
    & scoop bucket add nerd-fonts
    Start-Sleep -Seconds 1
    DisplayScoopInstallerMenu
}

function DisplayScoopInstallerMenu
{
    Clear-Host
    Write-Host @"
+===============================================+
|          SCOOP PACKAGES INSTALLER             |
+===============================================+
|                                               |
|    1) General                                 |
|    2) Programming                             |
|    3) Utilities                               |
|    4) Neovim                                   |
|    0) EXIT                                    |
+===============================================+

"@

    $menuChoice = Read-Host "OPTION"

    switch ($menuChoice)
    {
        1
        { InstallPackages "scoop" $scoopGeneral
        }
        2
        { InstallPackages "scoop" $scoopLang
        }
        3
        { InstallPackages "scoop" $scoopUtils
        }
        4
        { InstallPackages "scoop" $scoopNvim
        }
        0
        { Clear-Host; break
        }
        default
        {
            Write-Host "Option not available"
            Start-Sleep -Seconds 2
            DisplayScoopInstallerMenu
        }
    }
}

function InstallPackages($installerType, $packages)
{
    $installCMD = ""
    $installedPackages = ""

    if ($installerType -eq "winget")
    {
        $installCMD = "winget install --id"
    } elseif ($installerType -eq "scoop")
    {
        $installCMD = "scoop install"
        $installedPackages = scoop list | Out-String
        Write-Host $installedPackages
    } else
    {
        Write-Host "Unsupported installer type: $installerType"
        return
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

# Start the main function
main


#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop" # exit when command fails

$dotfilesRepo = "https://github.com/vunhatchuong/.dotfiles.git"
$dotfilesManager = "dotter"
$dotfilesManagerDeployCMD = "dotter"
$dotfilesDirectory = "$env:USERPROFILE\.dotfiles"

function InstallScoop
{
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
}

function InstallDotfilesManager
{
    if ($null -eq (Get-Command $dotfilesManager -ErrorAction SilentlyContinue))
    {
        Write-Host "No $dotfilesManager found."
        Write-Host "Installing $dotfilesManager"
        scoop install $dotfilesManager
    } else
    {
        Write-Host "$dotfilesManager is installed."
    }
}

function InstallDotfiles
{
    Write-Host "Starting fresh Computer installation script"
    if (-not (Test-Path $dotfilesDirectory))
    {
        Write-Host "Cloning dotfiles to $dotfilesDirectory"
        git clone $dotfilesRepo $dotfilesDirectory
    }

    Write-Host "Download and installing dotfiles..."
    Start-Sleep -Seconds 2

    # Save the current location
    $currentLocation = Get-Location
    # Change the location temporarily
    Set-Location -Path $dotfilesDirectory
    # Run the specified command
    & $dotfilesManagerDeployCMD
    # Revert to the original location
    Set-Location -Path $currentLocation
}

function InstallPackages
{
    $answer = Read-Host "Running install-packages.ps1? [y]es or [n]o (default: no) "
    if ("$answer" -eq "y" -or "$answer" -eq "Y")
    {
        Start-Sleep -Seconds 1
        & "./install-packages.ps1"
    }
    Write-Output "Skipping install packages"
    return
}

InstallScoop
InstallDotfilesManager
InstallDotfiles
InstallPackages




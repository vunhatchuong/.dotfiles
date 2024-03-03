#!/usr/bin/env bash

# Load external script
source ./packages.sh

main() {
    clear
    showMainMenu
}

showMainMenu() {
    cat <<EOF
+===============================================+
|                   MAIN MENU                   |
+===============================================+
|                                               |
|    1) Apt Package Installer                   |
|    2) Pacstall Package Installer              |
|    3) Curl Package Installer                  |
|    4) Setup                                   |
|    0) EXIT                                    |
+===============================================+

EOF

    read -p "OPTION: " userChoice

    case $userChoice in
        1) installWithApt ;;
        2) installWithPacstall ;;
        3) installWithCurl ;;
        4) setup ;;
        0) echo "Exiting"; exit 0 ;;
        *) echo "Option not available"; sleep 2; showMainMenu ;;
    esac
}

installWithApt() {
    clear
    installPackages "apt" "${aptPkgs[@]}"
}

installWithPacstall() {
    clear
    echo "Checking if Pacstall exists..."
    if ! command -v pacstall &>/dev/null; then
        echo "Pacstall doesn't exist, installing Pacstall and Git."
        sleep 1
        sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"
        pacstall install git
    else
        echo "Pacstall exists, updating Pacstall."
        sleep 1
        pacstall install git
        pacstall update *
    fi

    sleep 1
    displayScoopInstallerMenu
}

displayScoopInstallerMenu() {
    clear
    cat <<EOF
+===============================================+
|          SCOOP PACKAGES INSTALLER             |
+===============================================+
|                                               |
|    1) General                                 |
|    2) GUI                                     |
|    0) EXIT                                    |
+===============================================+

EOF

    read -p "OPTION: " menuChoice

    case $menuChoice in
        1) installPackages "pacstall" "${PacstallPkgs[@]}" ;;
        2) installPackages "pacstall" "${guiPkgs[@]}" ;;
        0) clear; break ;;
        *) echo "Option not available"; sleep 2; displayScoopInstallerMenu ;;
    esac
}

installPackages() {
    installerType=$1
    packages=("${@:2}")
    installCMD=""
    installedPackages=""

    if [ "$installerType" == "apt" ]; then
        installCMD="sudo apt update && sudo apt install -y ${packages}"
    elif [ "$installerType" == "pacstall" ]; then
        installCMD="pacstall -S"
        installedPackages=$(pacstall list | tr '\n' ' ')
        echo "Already installed packages: $installedPackages"
    else
        echo "Unsupported installer type: $installerType"
        return
    fi

    echo "Installing missing $installerType dependencies..."

    for package in "${packages[@]}"; do
        if [[ ! $installedPackages =~ $package ]]; then
            echo "Installing missing dependency: $package"
            $installCMD $package
        fi
    done

    echo "Finishes, returning to menu..."
    sleep 2
    showMainMenu
}

installWithCurl() {
    clear
    if ! checkInstalled "zap"; then
        echo "Installing zap..."
        zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
    fi
    if ! checkInstalled "micromamba"; then
        echo "Installing micromamba..."
        "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
    fi
}

setup() {
    echo "Change shell..."
    chsh -s $(which zsh)
    . "${HOME}/.config/zsh/.zprofile"
}

checkInstalled() {
    if command -v "$1" &>/dev/null || type "$1" &>/dev/null; then
        echo "Existed, skipping installation"
        true
    else
        echo "Doesn't exist"
        false
    fi
}

# Start the main function
main


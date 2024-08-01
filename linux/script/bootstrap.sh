#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status

dotfilesRepo="https://github.com/vunhatchuong/.dotfiles.git"

installPacstall() {
    clear
    echo "Checking if Pacstall exists..."
    if ! command -v pacstall &>/dev/null; then
        echo "Pacstall doesn't exist, installing Pacstall and Git."
        sleep 1
        sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"
        # pacstall install git
    else
        echo "Pacstall exists, updating Pacstall."
        sleep 1
        pacstall -U
        # pacstall -S git
    fi
}

function installDotfilesManager() {
    if ! command -v "dotter" &>/dev/null; then
        echo "No dotter found."
        echo "Installing dotter"
        scoop install "$dotfilesManager"
    else
        echo "dotter already installed."
    fi
}

function installDotfiles() {
    echo "Starting fresh Computer installation script"
    read -rep $'\nWhere do you want to clone these dotfiles to [~/.dotfiles]? ' clone_path
    clone_path="${clone_path:-"${HOME}/.dotfiles"}"

    # Ensure path doesn't exist.
    while [ -e "${clone_path}" ]; do
        read -rep $'\nPath exists, try again? (y) ' y
        case "${y}" in
            [Yy]*)

                break;;
            *) echo "Please answer y or CTRL+c the script to abort everything";;
        esac
    done

    git clone "$dotfilesRepo" "${clone_path}"
}

function installPackages() {
    read -p "Running install-packages.sh? [y]es or [n]o (default: no) " answer
    if [ "${answer,,}" == "y" ]; then
        sleep 1
        sudo ./install-packages.sh
    else
        echo "Skipping install packages"
    fi
}

installPacstall
installDotfilesManager
installDotfiles
installPackages


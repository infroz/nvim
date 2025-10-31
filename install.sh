  GNU nano 7.2                                                                                                             install.sh
#!/bin/bash
# Script to update and install the latest Neovim from the nightly branch

# Exit immediately if a command exits with a non-zero status.
set -e

# Navigate to the neovim source directory
# update: adjust path to install in config location
mkdir -p ~/.config/nvim/
cd ~/.config/nvim/

## check if folder exists
if [ ! -d ~/.config/nvim/neovim.git ]; then
        ## should be in .config/nvim
        git clone https://github.com/neovim/neovim neovim.git
fi

cd ~/.config/nvim/neovim.git
git checkout nightly
git pull origin nightly

## update apt
sudo apt-get update

## Install neovim deps
## https://github.com/neovim/neovim/wiki/Building-Neovim/688be28f98c18e73b5043879b5963287a9b13d6c#ubuntu--debian
sudo apt-get install ninja-build gettext cmake unzip curl

## Install neovim plugin deps
sudo apt-get install fzf ripgrep

## install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc

pnpm env use --global lts

echo "--- Cleaning up old build artifacts ---"
# Thoroughly clean the project before building
make distclean

echo "--- Compiling Neovim ---"
# Compile with Release optimization and Debug Info
make CMAKE_BUILD_TYPE=RelWithDebInfo

echo "--- Packaging the .deb file ---"
cd ~/neovim/build && cpack -G DEB
echo "--- Installing the new Neovim package ---"
sudo dpkg -i nvim-linux-x86_64.deb

echo "--- Update Complete! ---"
echo "Neovim version:
nvim -v

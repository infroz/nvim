#!/bin/bash
# Script to update and install the latest Neovim from the nightly branch

# Exit immediately if a command exits with a non-zero status.
set -e

# Navigate to the neovim source directory
cd ~/neovim

echo "--- Pulling latest changes from nightly branch ---"
git pull origin nightly

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
echo "Neovim version:"
nvim -v

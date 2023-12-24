#!/usr/bin/env bash

ROOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Helper Functions                                            #
# =========================================================== #

function is_os_macos() { [[ $OSTYPE = darwin* ]]; }
function is_os_debian() { type lsb_release >/dev/null 2>&1 && [[ $(lsb_release -is) = Debian ]]; }
function command_exists() { type -p "$1" >/dev/null 2>&1; }

# XDG
# =========================================================== #

XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
XDG_DATA_HOME="${HOME}/.local/share"
XDG_STATE_HOME="${HOME}/.local/state"
XDG_BIN_HOME="${HOME}/.local/bin"
XDG_RUNTIME_DIR="${HOME}/.local/runtime"

mkdir -p ${XDG_CONFIG_HOME} ${XDG_CACHE_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME} ${XDG_BIN_HOME} ${XDG_RUNTIME_DIR}

# System
# =========================================================== #

if is_os_macos; then
  ./scripts/package-macos.sh
  ./scripts/macos-defaults.sh
elif is_os_debian; then
  ./scripts/package-debian.sh
else
  echo -e "Unsupported OS."
  exit 1
fi

# Shell
# =========================================================== #

zsh_bin=$(which zsh)
if is_os_macos; then
  zsh_bin="/opt/homebrew/bin/zsh"
fi

# Add zsh to /etc/shells
grep -qF /opt/homebrew/bin/zsh /etc/shells || echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells

# Set default shell
echo -e "Setting default shell ..."
sudo chsh -s ${zsh_bin} $USER

# Config
# =========================================================== #

# asdf
cp -fR ${ROOT_DIR}/config/asdf ${XDG_CONFIG_HOME}

# git
cp -fR ${ROOT_DIR}/config/git ${XDG_CONFIG_HOME}

# zsh
mkdir -p ${XDG_CONFIG_HOME}/zsh
cp -f ${ROOT_DIR}/config/zsh/zshenv ${HOME}/.zshenv
cp -f ${ROOT_DIR}/config/zsh/zshrc ${XDG_CONFIG_HOME}/zsh/.zshrc
cp -fR ${ROOT_DIR}/config/zsh/config ${XDG_CONFIG_HOME}/zsh

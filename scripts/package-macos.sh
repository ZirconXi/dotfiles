#!/usr/bin/env bash

function command_exists() { type -p "$1" >/dev/null 2>&1; }

# Install Homebrew
if ! command_exists brew; then
  echo -e "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "Homebrew is installed."
fi

# Make sure Homebrew is the latest version.
brew update

# Install Taps
taps=(
  homebrew/cask-fonts
  homebrew/cask-versions
)
for tap in "${taps[@]}"; do
  echo -e "Installing Homebrew tap (${tap}) ..."
  brew tap ${tap}
done

# Install Formulaes
formulaes=(
  coreutils # common (begin)
  gawk
  git
  neofetch
  neovim
  tldr
  trash
  wget      # common (end)
  openssl   # python build dependencies (begin)
  readline
  sqlite3
  xz
  zlib
  tcl-tk    # python build dependencies (end)
)

for formulae in "${formulaes[@]}"; do
  echo -e "Installing Homebrew formulae (${formulae}) ..."
  brew install ${formulae}
done

# Install Casks
casks=(
  appcleaner              # Application uninstaller
  bartender               # Menu bar icon organizer
  bitwarden               # Password manager
  firefox                 # Web browser
  fliqlo                  # Flip clock screensaver
  font-ubuntu-mono
  font-ubuntu-mono-nerd-font
  iina                    # Free and open-source media player
  intellij-idea           # IDE by JetBrains
  iterm2                  # Terminal emulator
  maczip                  # Utility to open, create and modify archive files
  obsidian                # Knowledge base
  orbstack                # Replacement for Docker Desktop
  rapidapi                # HTTP client that helps testing and describing APIs
  raycast                 # Control your tools with a few keystrokes
  snipaste                # Snip or pin screenshots
  spotify                 # Music streaming service
  stats                   # System monitor for the menu bar
  synology-drive          # Sync and backup service to Synology NAS drives
  visual-studio-code      # Open-source code editor
)

for cask in "${casks[@]}"; do
  echo -e "Installing Homebrew cask (${cask}) ..."
  brew install --cask --adopt ${cask}
done

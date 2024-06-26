#!/bin/bash
xcode-select --install
/bin/bash curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

brew bundle
brew install $(brew search font | grep nerd | tr '\n' ' ')

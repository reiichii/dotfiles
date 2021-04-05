#!/bin/bash

set -u

WORK_DIR = pwd
cd WORK_DIR

echo 'install homebrew'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'set dot_files'
cp .gitignore_global /Users/$(whoami)

echo 'install applications from Brewfile'
brew bundle

echo 'install sync-settings in Atom'
apm install sync-settings

echo 'copy settings files'
cp .tmux.conf ~/.tmux.conf

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END

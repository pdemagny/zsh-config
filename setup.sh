#!/usr/bin/env bash

set -e

sudo apt-get install -y git curl fonts-powerline
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --unattended
sudo mkdir -p /usr/share/zsh-antigen/ && curl -L git.io/antigen >/tmp/antigen.zsh && sudo mv /tmp/antigen.zsh /usr/share/zsh-antigen/
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
mkdir -p ~/.local/share/fonts
(cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf)
fc-cache
cp -v ./.zsh.aliases ./.zsh-aliases.txt ./.zsh.comp ./.zsh.env .zshrc ~
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

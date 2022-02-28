mv -n dotfiles ~
cd ~
ln -s dotfiles/.zshenv .
ln -s dotfiles/.zsh .

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# vimはやめた
# ln -s dotfiles/.vimrc .
# ln -s dotfiles/.vim .

ln -s dotfiles/.gitconfig .

# miniconda install
printf "Install miniconda (for Ubuntu)?(y/N): "
if read -q; then
    zsh dotfiles/minicondaInstallUbuntu.sh
else
    echo "Skip!"
fi

# neovim install
printf "Install neovim (for Ubuntu)?(y/N): "
if read -q; then
    zsh dotfiles/nvimInstallUbuntu.sh
else
    echo "Skip!"
fi

# nvim
printf "Install neovim settings?(y/N): "
if read -q; then
    if [ ! -d "$~/.config" ]; then
	mkdir -p ~/.config
    fi
    ln -s ../dotfiles/.config/nvim .config
    echo ""
else
    echo "Skip!"
fi

# screen
printf "Install screen settings?(y/N): "
if read -q; then
    ln -s dotfiles/.screenrc .
    echo ""
else
    echo "Skip!"
fi

# git pull
cd dotfiles
git submodule update -i
cd ~

# myScript
ln -s dotfiles/.myscript .

# latexmk
ln -s dotfiles/.latexmkrc .

# tig
ln -s dotfiles/.tigrc .

# notify
ln -s dotfiles/.notify.sh .

# starship
ln -s ../dotfiles/.config/starship.toml .config

echo "Finish!!!"

cp dotfiles/localfiles/.zshrc.local .
cp dotfiles/localfiles/.gitconfig.local .
echo "$HOME/.gitconfig.localと$HOME/.zshrc.localを編集してください"

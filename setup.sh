mv -n dotfiles ~
cd ~
ln -s dotfiles/.zshenv .
ln -s dotfiles/.zsh .

# vimはやめた
# ln -s dotfiles/.vimrc .
# ln -s dotfiles/.vim .

ln -s dotfiles/.gitconfig .

# nvim
echo "Install neovim settings?(y/N): "
if read -q; then
    if [ ! -d "$~/.config" ]; then
	mkdir ~/.config
    fi
    ln -s ../dotfiles/.config/nvim .config
else
    echo "Skip!"
fi

# screen
echo "Install screen settings?(y/N): "
if read -q; then
    ln -s dotfiles/.screenrc .
else
    echo "Skip!"
fi

# git pull
cd dotfiles
git submodule update -i
cd ~

# myScript
ln -s dotfiles/.myscript .

echo "Finish!!!"

cp dotfiles/localfiles/.zshrc.local .
cp dotfiles/localfiles/.gitconfig.local .
echo "$HOME/.gitconfig.localと$HOME/.zshrc.localを編集してください"

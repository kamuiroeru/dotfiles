## my Dotfiles
### Requirements
- curl
- git
- zsh
- neovim
    - pynvim 
- screen
- gawk (無くても良いが、zplugでエラーが出る)
- fzy（などのインタラクティブフィルタ）

もしminicondaもインストールするなら、
- bzip2

zplugを実行するときに、 `perl: warning: Setting locale failed.` が出て鬱陶しいので、先に

sudo apt install locales-all

を実行しておくことをおすすめします。

#### How To Use
1. `git clone https://github.com/kamuiroeru/dotfiles.git
2. `source dotfiles/setup.sh`
3. modify `$HOME/.zshrc.local`
   if you use conda, edit `$CONDA_ROOT=path/to/conda/root`

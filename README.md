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


#### How To Use
1. `git clone https://github.com/kamuiroeru/dotfiles.git -b mbp`
2. `source dotfiles/setup.sh`
3. modify `$HOME/.zshrc.local`
   if you use conda, edit `$CONDA_ROOT=path/to/conda/root`

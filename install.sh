# tmux
ln -s ~/DotFiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zshrc
rm ~/.zshrc
ln -s ~/DotFiles/.zshrc ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/sources/zsh-syntax-highlighting

#neovim
ln -s ~/DotFiles/init.vim ~/.config/nvim/init.vim

#VimPlug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

touch ~/.env

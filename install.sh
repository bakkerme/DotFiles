echo "Make sure you install: Zsh, Neovim, Tmux, Node, NPM, ag"
read ans

mkdir ~/sources
mkdir ~/.npm-packages

# git
git config --global user.email "brandon@bdmd.com.au"
git config --global user.name "Brandon Bakker"

# tmux
ln -s ~/DotFiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s ~/DotFiles/.zshrc ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/sources/zsh-syntax-highlighting

#neovim
mkdir -p ~/.config/nvim/
ln -s ~/DotFiles/init.vim ~/.config/nvim/init.vim

#VimPlug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/sourcegraph/javascript-typescript-langserver.git ~/sources/javascript-typescript-langserver

touch ~/.env

npm config set prefix=$HOME/.npm-packages

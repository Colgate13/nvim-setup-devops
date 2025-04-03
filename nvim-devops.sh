sudo apt update && \
sudo apt install -y curl software-properties-common && \
sudo add-apt-repository ppa:neovim-ppa/stable -y && \
sudo apt update && \
sudo apt install -y neovim && \
mkdir -p ~/.config/nvim && \
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
cat > ~/.config/nvim/init.vim << 'EOF'
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'

call plug#end()

syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
colorscheme dracula
EOF && \
nvim +PlugInstall +qall

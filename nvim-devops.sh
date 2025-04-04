#!/bin/bash

set -e  # Para sair se algum comando falhar

echo "📦 Instalando dependências..."
sudo apt update && \
sudo apt install -y curl git software-properties-common clangd

echo "🔧 Instalando Rust e rust-analyzer..."
curl https://sh.rustup.rs -sSf | sh -s -- -y && \
source $HOME/.cargo/env && \
rustup component add rust-analyzer

echo "🧠 Verificando versão do Neovim:"
nvim --version | head -n 1

echo "📁 Configurando Neovim e plugins..."
mkdir -p ~/.config/nvim && \
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cat << 'EOF' > ~/.config/nvim/init.vim
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

call plug#end()

syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
colorscheme dracula
EOF

echo "📦 Instalando plugins com PlugInstall..."
nvim +PlugInstall +qall

echo "⚙️ Instalando extensões do CoC (C e Rust)..."
echo ":CocInstall coc-clangd coc-rust-analyzer | qall" > ~/.config/nvim/coc-setup.vim && \
nvim -u ~/.config/nvim/init.vim -S ~/.config/nvim/coc-setup.vim && \
rm ~/.config/nvim/coc-setup.vim

echo "✅ Neovim configurado com sucesso com suporte a C e Rust!"

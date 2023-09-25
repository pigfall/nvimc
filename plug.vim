call plug#begin('~/.vim/plugged')
" { colorscheme
Plug 'EdenEast/nightfox.nvim'
" }
" { NERTTree
Plug 'scrooloose/nerdtree'
" }
" { coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }
" { telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" }
" { Treesitter
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" }
" { lua snippets
Plug 'L3MON4D3/LuaSnip'
" }
" { bookmark
Plug 'MattesGroeger/vim-bookmarks'
" }
" { easymotion
Plug 'easymotion/vim-easymotion'
" }
" {
Plug 'fatih/vim-go'
" }
"{
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"}
Plug 'jbyuki/venn.nvim'
call plug#end()

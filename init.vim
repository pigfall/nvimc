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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
"}
call plug#end()

" { တ common_keymap
let mapleader = "'" 

" {{ switch mode between normal and insert
inoremap <Leader>w <ESC>:wa<CR>
nnoremap <Leader>w :wa<CR>
inoremap jk <ESC>
" }}

" {{ buffer operation
nnoremap <s-u> :e#<CR> " swithc to last edit option
" }}

" {{ quick access config file
" set -es to edit VIMRC
lua << EOF
	local first_runtime_path_index = string.find(vim.o["runtimepath"],",") - 1
	local first_runtime_path =  string.sub(vim.o["runtimepath"],0,first_runtime_path_index)
	vim.cmd(string.format("nnoremap -e :e %s/init.vim <CR>",first_runtime_path))
	local init_vim_filepath = string.format("%s/init.vim",first_runtime_path)
	vim.cmd(string.format("nnoremap -es :e %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("nnoremap -ss :source %s/init.vim <CR>",first_runtime_path))
	vim.cmd(string.format("let g:init_vim='%s'",init_vim_filepath))
EOF

" }}

" {{ window operation
nnoremap <Leader>q :q<CR>
nnoremap <Leader>vs :vs<CR>
" }}

" {{ terminal operation
nnoremap <Leader>tt :tabnew<CR>:terminal<CR>
nnoremap <Leader>tc :terminal<CR>
nnoremap <Leader>tp :lua require("utils").term_in_cur_file_dir()<CR>
nnoremap <Leader>ts :vs<CR><c-w>l:terminal<CR>
" switch from terminal insert mode to normal mode
tnoremap <c-j> <c-\><c-n> 
" }}
" {{ tab operation
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
" }}
" }

" { တ insert modifier
inoremap <cr> <Cmd> call TzzEnter()<Cr>
inoremap ) <Cmd> call  TzzFeedLeftParenthese()<CR>
inoremap { {}<left>
inoremap ( ()<left>
" }

" { တ command mode modifier
cnoremap <c-b> <left>
cnoremap <c-f> <right>
" }

" { တ cursor movement
inoremap <c-a> <ESC>0a
inoremap <c-n> <Down>
inoremap <c-p> <Up>
inoremap <c-f> <Right>
inoremap <c-b> <Left>
inoremap <M-f> <ESC>ea
inoremap <c-j> <ESC>o
inoremap <c-e> <ESC>A
" }

" { တ abbrevitations
" {{ တ special character
ab :flower: 🌸
ab :tada: 🎉
ab :cross: ❌
ab :check: ✅
ab :warning: ⚠️
ab :bug: 🐛
ab :devil: 😈
ab :ch: တ
ab :yy: ဈ
ab :loading: ⌛
" }}
" }
"

" { တ colorscheme
colorscheme nightfox
" make bg transparent
hi Normal ctermbg=NONE guibg=NONE
hi NormalNC ctermbg=NONE guibg=NONE
" }

" { တ common_option
" {{ ident
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
" }}
" {{ case
set ignorecase
set smartcase
" }}
" {{ mouse
set mouse=
" }}
" }

" { တ NERDTree
nnoremap <Leader>nn :NERDTree<CR>
nnoremap <Leader>nc :NERDTreeClose<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <s-e> :NERDTreeToggle<CR>
" }

" { တ telescope
nnoremap <Leader>f <cmd>Telescope find_files<cr>
inoremap <M-p> <cmd>Telescope find_files<cr>
inoremap <M-P> <cmd>Telescope buffers<cr>
nnoremap <Leader>b <cmd>Telescope buffers<cr>
lua << EOF
  require('telescope').setup{ defaults = { file_ignore_patterns = {"^build/.*","build\\.*","target","\\.git"} } }
EOF
" }

" { တ bookmark
nmap <Leader>mt <Plug>BookmarkToggle
nmap <Leader>ma  <Plug>BookmarkAnnotate
nmap <Leader>ms  <Plug>BookmarkShowAll
let g:bookmark_no_default_key_mappings = 1
" }

" { တ easymotion
nmap <Leader>g <Plug>(easymotion-s2)
" }

" { တ common_lua_script
lua << EOF
	local utils = require("utils")
	local vimfn = vim.fn
	function tzzJumpToDef(doJump,doBeforeJump)
      print("tzzJumpToDef")
	    if utils.buffer_modified() and (vimfn.len(vimfn.win_findbuf(vimfn.bufnr('%'))) < 2 ) then
		vim.cmd("normal -vs<CR>")
	    end
	    -- vim.lsp.buf.definition()
      if doBeforeJump then
        doBeforeJump()
      end
	    doJump()
	end
EOF
" }

" { တ coc
let lang_list = ["go,dart,rust"]

lua << EOF
	function tzz_coc_jump_def_wrapper()
		vim.cmd("call CocActionAsync('jumpDefinition')")
	end

	function tzz_coc_jump_def()
		tzzJumpToDef(tzz_coc_jump_def_wrapper)
	end
EOF

augroup tzz-coc
	au! 
	exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-o> coc#refresh()"
	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-]> :lua tzz_coc_jump_def()<CR>"
	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-n> <Plug>(coc-diagnostic-next-error)" 
	exec "autocmd FileType " . join(lang_list,",") . " nmap <buffer> <c-d><c-n> <Plug>(coc-diagnostic-next)" 
	exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <c-n> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? \"\<Tab>\" : coc#refresh()" 
	exec "autocmd FileType " . join(lang_list,",") . " inoremap <expr> <c-p> coc#pum#visible() ? coc#pum#prev(1) : \"\<C-h>\"" 
	exec "autocmd FileType " . join(lang_list,",") . " nmap gr <Plug>(coc-references)" 
	exec "autocmd FileType " . join(lang_list,",") . " nmap gi <Plug>(coc-implementation)" 
  exec "autocmd FileType " . join(lang_list,",") . " inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>i\""
augroup end
" }

" { lua snippets
lua << EOF
require("luasnip.loaders.from_snipmate").lazy_load()
EOF
imap <silent><expr> <c-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
snoremap <silent> <c-l> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
" }

" { တ treesitter
"lua << EOF
"require'nvim-treesitter.configs'.setup {
"  highlight = {
"    -- `false` will disable the whole extension
"    enable = true,
"
"    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
"    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
"    -- the name of the parser)
"    -- list of language that will be disabled
"    disable = { "c", "rust" },
"
"    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
"    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
"    -- Using this option may slow down your editor, and you may see some duplicate highlights.
"    -- Instead of true it can also be a list of languages
"    additional_vim_regex_highlighting = false,
"  },
"}
"EOF
" }

"{ တ vim-go
let g:go_gopls_enabled = 0
let g:go_imports_autosave = 0
let g:go_fmt_autosave =0
"}

" { some features only need in local dev
lua << EOF
local status,module = pcall(require,"local")
if not status then
  if not string.find(module,"not found") then
    print(module)
  end
end
EOF
" }

"=========================================================================
" VimPlug
"=========================================================================
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'                  "ファジーファインダー
Plug 'junegunn/fzf.vim'
Plug 'jimsei/winresizer'                   "ウィンドウリサイズ
Plug 'itchyny/lightline.vim'               "ステータスライン拡張
Plug 'nathanaelkane/vim-indent-guides'     "インデントの可視化
Plug 'airblade/vim-gitgutter'              "編集箇所を差分表示
Plug 'tpope/vim-commentary'                "コメントを入力補完
Plug 'tpope/vim-surround'                  "範囲選択を拡張
Plug 'prabirshrestha/vim-lsp'              "lsp用プラグイン
Plug 'prabirshrestha/async.vim'            "vim-lspの補助
Plug 'prabirshrestha/asyncomplete.vim'     "入力補完
Plug 'prabirshrestha/asyncomplete-lsp.vim' "入力補完の補助
Plug 'tpope/vim-fugitive'                  "git用プラグイン
Plug 'twitvim/twitvim'                     "twitter用プラグイン
Plug 'VincentCordobes/vim-translate'       "翻訳プラグイン
Plug 'mattn/emmet-vim'                     "html/cssを入力補完
Plug 'vim-scripts/todo-txt.vim'            "todo-txt用プラグイン
Plug 'previm/previm'                       "markdownをプレビュー
Plug 'dhruvasagar/vim-table-mode'          "表作成を入力補完

call plug#end()


"=========================================================================
" Vimの標準設定
"=========================================================================
set nocompatible                "viとの互換性を無効にする
syntax enable                   "シンタックスハイライトを有効にする
filetype plugin indent on       "ファイル形式ごとを有効にする
colorscheme jellybeans          "カラースキームを設定する
let mapleader = "\<Space>"      "Leader keyを設定する
set number                      "行番号を表示する
set cursorline                  "カーソルラインを表示する
set ruler                       "常にカーソル位置を表示する
set laststatus=2                "常にステータス行を表示する
set showcmd                     "未完のコマンドを表示する
set wildmode=longest,list       "Exコマンドの候補をリスト表示する
set history=1000                "Exコマンドの履歴保持数を1000に増やす
set expandtab                   "タブ文字を半角スペースに変換する
set autoindent                  "改行時に前の行のインデントを継続する
set tabstop=4                   "タブ・スペースの文字数を設定する
set shiftwidth=4                "自動インデントの文字数を設定する
set softtabstop=4               "連続したスペースをまとめて削除する
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *.css setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
set backspace=2                 "Ctrl-hの対象を増やす
set list                        "不可視文字を表示する
set listchars=tab:▸\ ,trail:.
set incsearch                   "インクリメンタルサーチを有効にする
set hlsearch                    "検索結果をハイライトする
set ignorecase                  "検索で大文字と小文字を区別しない
set wrapscan                    "最後尾の検索候補まで行ったら先頭に戻る
set hidden                      "ファイルが未保存でもバッファを移動する
set splitbelow                  "水平分割時に下にウィンドウを開く
noremap bb :ls<CR>:b
nnoremap Y y$
vnoremap > >gv
vnoremap < <gv


"=========================================================================
" 日付を自動で入力する
"=========================================================================
nmap ,dt <Esc>i<C-R>=strftime("%F %T")<CR><Esc>0
ia dt <C-R>=strftime("%F %T")<CR>


"=========================================================================
" fzf
"=========================================================================
nnoremap <silent> <Leader>o :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>h :History<CR>
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


"=========================================================================
" vim_indent_guide
"=========================================================================
let g:indent_guides_enable_on_vim_startup = 1   "Vim開始時に起動する
hi IndentGuidesOdd  ctermbg=232
hi IndentGuidesEven ctermbg=236


"=========================================================================
" vim-gitgutter
"=========================================================================
set signcolumn=yes                       "シンボルカラムを常に表示する
set updatetime=250                       "更新するタイミングを250msに変更する


"=========================================================================
" vim-lsp
"=========================================================================
let g:lsp_diagnostics_echo_cursor = 1    "エラー内容をステータスバーに表示する

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif


"=========================================================================
" asyncomplete
"=========================================================================
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"


"=========================================================================
" vim-translate
"=========================================================================
vnoremap <silent> <leader>tl :TranslateVisual<CR>
vnoremap <silent> <leader>tr :TranslateReplace<CR>
nmap <leader>tl <Plug>Translate
nmap <leader>tr <Plug>TranslateReplace

let g:translate#default_languages = {
      \ 'en': 'ja',
      \ 'ja': 'en'
      \ }


"=========================================================================
" emmet-vim
"=========================================================================
let g:user_emmet_leader_key='<C-e>' "emmet起動のキーバインドを設定する


"=========================================================================
" Previm
"=========================================================================
nnoremap <silent> <Leader>p :PrevimOpen<CR>
let g:previm_open_cmd = 'open -a Safari'
let g:previm_show_header = 0


"=========================================================================
" vim-table-mode
"=========================================================================
let g:table_mode_corner='|'

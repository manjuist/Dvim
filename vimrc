" Environment {
    " Basics {
        set nocompatible        " Must be first line
    " }

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }
" }

" Behavior {
    "set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    "set backspace=indent,eol,start  " Backspace for dummies
    set softtabstop=4               " Let backspace delete indent
    set scrolljump=5               " Lines to scroll when cursor leaves screen
    set shiftwidth=4                " Use indents of 4 spaces
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set autoindent                  " Indent at the same level of the previous line
    set ignorecase                  " Case insensitive search
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set incsearch                   " Find as you type search
    set smartcase                   " Case sensitive when uc present
    set showmatch                   " Show matching brackets/parenthesis
    set hlsearch                    " Highlight search terms
    set nowrap
    set number                      " Line numbers on

    "Backup file{
        set noswapfile
        set noundofile
        set nobackup
        set nowb
    "}

    "File{
        filetype plugin indent on   " Automatically detect file types.
        syntax on                   " Syntax highlighting
    "}
"}

" UI {
    set go=
    set wildmenu                    " Show list instead of just completing
    set cursorline                  " Highlight current line
    set linespace=0                 " No extra spaces between rows
    set laststatus=2
    set winminheight=0              " Windows can be 0 line high
    set background=dark
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

    "Colors{
    if filereadable(expand("~/.vim/bundle/molokai/colors/molokai.vim")) && filereadable(expand("~/.vim/bundle/vim-distinguished/colors/distinguished.vim"))
        if has("gui_running")
            colorscheme molokai
        else
            set t_Co=256
            colorscheme distinguished
        endif
    endif
    "}
    
    "Fonts{
        if LINUX()
            set guifont=Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 12
        elseif OSX()
            set guifont=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h12
        elseif WINDOWS()
            set guifont=Source_Code_Pro:h12,Bitstream_Vera_Sans_Mono:h12
        endif
    "}
" }

"Encode{
	if has("multi_byte")
        " Powershell as the primary terminal, this would be utf-8
		set termencoding=utf-8
        "set termencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
	endif
"}

"Auto load vimrc{
    if has("autocmd")
        if LINUX()
            autocmd! bufwritepost .vimrc source $MYVIMRC
        else
            autocmd! bufwritepost _vimrc source $MYVIMRC
        endif
    endif
"}

" Bundles {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }
" vim-plug {
    "if filereadable(expand("~/.vimrc.plugins"))
        "source ~/.vimrc.plugins
    "endif
" }

"Mappings{
    let mapleader = ","
    nmap <leader>y "+y
    nmap <leader>p "+p
    nmap <leader>w :w<CR>
    nmap <leader>q :q<CR>
    nmap <leader>h <c-w>h
    nmap <leader>j <c-w>j
    nmap <leader>k <c-w>k
    nmap <leader>l <c-w>l
    nmap <leader>r :reg<CR>
    nmap <leader>1 :vertical resize 120<CR>
    nmap <leader>2 :vertical resize 25<CR>
    nmap j gj
    nmap k gk
"}

"Plugin Config Start{
    " airline{
        let g:airline#extensions#tabline#enabled=1
        let g:airline#extensions#tabline#left_sep = ' '
        let g:airline#extensions#tabline#left_alt_sep = '|'
    " }

    " Indent{
        let g:indent_guides_guide_size= 1
        let g:indent_guides_auto_colors = 0
        let g:indent_guides_enable_on_vim_startup = 1
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#333333
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#000000
    " }

    " Easemotion{
        let g:EasyMotion_smartcase = 1
        map <Leader><Leader>j <Plug>(easymotion-j)
        map <Leader><Leader>k <Plug>(easymotion-k)
        map <Leader><leader>. <Plug>(easymotion-repeat)
        map <Leader><leader>l <Plug>(easymotion-lineforward)
        map <Leader><leader>h <Plug>(easymotion-linebackward)
    " }

    " Emmet{
        let g:user_emmet_expandabbr_key='<Leader><tab>'
    " }

    " NeoComplete{
        let g:neocomplete#enable_at_startup=1
        nmap <Leader><Leader>n :NeoCompleteToggle<CR>
    " }

    " Incsearch{
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            map <leader>n :NERDTreeToggle<CR>
            map <leader>e :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " Tagbar{
        nmap <Leader>t :TagbarToggle<CR>
    " }
"}

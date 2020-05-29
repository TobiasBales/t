
" ## Settings {{{

" map*leader {{{
let mapleader=" "
let maplocalleader="\\"
" }}}

" TTY Performance {{{
set nocompatible
set synmaxcol=300
set ttyfast
set lazyredraw
" }}}

" Backup/swap/undo Directories {{{
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/swaps
set undodir=~/.config/nvim/undo
set undofile
" }}}

" Environment {{{ 
" map */+ registers to macOS pastebuffer
set clipboard=unnamed
" Disable beeps and flashes
set noerrorbells visualbell t_vb=
set encoding=utf-8
" }}}

" Whitespace handling {{{
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:»·,trail:·
" }}}

" Searching {{{
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}

" Tab completion {{{
set wildmode=list:longest,list:full
" set wildmode=list:longest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/tmp/*,*.so,*.swp,*.zip
" }}}

" Gutter Line Numberings {{{
set rnu
set nu
set numberwidth=1
" }}}

" Enable Mouse in TTY {{{
if has("mouse")
  set mouse=a
endif
" }}}

" Timeout configuration for (e.g.) kj insert mode mapping {{{
set notimeout
set ttimeout
set timeoutlen=20
" }}}

" (Miscellaneous Settings) {{{
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set printfont=PragmataPro:h12
set fillchars+=vert:│
set scrolloff=3
set autoindent
set autoread
set showmode
set showcmd
set hidden
set nocursorline
set ruler
set laststatus=2
set concealcursor=""
" write before make
set autowrite
" }}}

" }}}

" NeoVim-specific {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Neovim takes a different approach to initializing the GUI. As It seems some
" Syntax and FileType autocmds don't get run all for the first file specified
" on the command line.  hack sidesteps that and makes sure we get a chance to
" get started. See https://github.com/neovim/neovim/issues/2953
augroup nvim
  au!
  au VimEnter * doautoa Syntax,FileType
augroup END
" }}}

" Syntax Highlighting {{{
if $TERM_BG == "light"
  set background=light
else
  set background=dark
endif
colorscheme gruvbox
" load the plugin and indent settings for the detected filetype
filetype plugin indent on
" }}}

" ## Plugin/Feature Configuration {{{

" Netrw {{{
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" }}}

" Supertab {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
" }}}

" Tagbar {{{
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

if executable('ripper-tags')
    let g:tagbar_type_ruby = {
                \ 'kinds' : [
                    \ 'm:modules',
                    \ 'c:classes',
                    \ 'f:methods',
                    \ 'F:singleton methods',
                    \ 'C:constants',
                    \ 'a:aliases'
                \ ],
                \ 'ctagsbin':  'ripper-tags',
                \ 'ctagsargs': ['-f', '-']
                \ }
endif
" }}}

" LightLine {{{
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
" }}}

" FZF {{{
nnoremap <leader>j :Buffers<cr>
nnoremap <leader><C-p> :Files<cr>
nnoremap <leader><C-s> :GFiles?<cr>
nnoremap <C-p> :GFiles<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>T :BTags<cr>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

" set shell=/usr/local/bin/zsh
augroup _term
  autocmd TermOpen term://* set nonu nornu
  " autocmd TermOpen term://* startinsert
augroup END

" }}}

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

" }}}

" ## Per-Filetype Configuration {{{

" Makefile {{{
augroup makefile
  au!
  au FileType make set noexpandtab
augroup END
" }}}

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" highlight occurrences of local on hover
let g:go_auto_sameids = 0

" type info in statusline
let g:go_auto_type_info = 1

let g:go_fmt_command = "goimports"

" gometalinter configuration
let g:go_metalinter_command = ""
let g:go_metalinter_deadline = "10s"
let g:go_metalinter_enabled = [
    \ 'deadcode',
    \ 'errcheck',
    \ 'gas',
    \ 'goconst',
    \ 'gocyclo',
    \ 'golint',
    \ 'ineffassign',
    \ 'vet',
    \ 'vetshadow'
\]
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
    " \ 'gosimple',
" }}}

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Ruby {{{
let g:ruby_indent_assignment_style = 'variable'
" }}}

" Miscellaneous (txt,md,lua,js,python,ruby-c) {{{
augroup misc_mode_extras
  au!
  au BufRead,BufNewFile *.lua       set ft=lua
  au BufRead,BufNewFile *.ronn      set ft=markdown
  au BufRead,BufNewFile *.json      set ft=javascript
  au BufRead,BufNewFile Gemfile     set ft=ruby
  au BufRead,BufNewFile Rakefile    set ft=ruby
  au BufRead,BufNewFile Vagrantfile set ft=ruby
  au BufRead,BufNewFile config.ru   set ft=ruby
  au BufRead,BufNewFile *.rbi       set ft=ruby
augroup END
" }}}

" }}}

if has('nvim')
  " Enable deoplete on startup
  let g:deoplete#enable_at_startup = 1
endif

" ## Mappings {{{

" jk = <esc> {{{
inoremap jk <esc>
" }}}


nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

let g:terraform_fmt_on_save=1

let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}

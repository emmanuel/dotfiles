set nocompatible
" {{{ Multiplatform compatibility

" win, osx, or unix?
if has('win32') || has('win64')
  let os="win"
elseif has("unix")
  let os=substitute(system('uname'), '\n', '', '')
  if os == "Mac" || os == "Darwin"
    let os = "osx"
  else
    let os = "unix"
  end  
else
  let os="?"
end

if os == "win"
  " Make windows use ~/.vim too, I don't want to use _vimfiles
  set runtimepath^=~/.vim
endif

" }}}
" {{{ Bundle configuration (must precede others)

" Temporarily turn off filetype detection (vundle requirement)
filetype off

" Add vundle to the runtime path
set rtp+=~/.vim/bundle/vundle/

" Call Vundle
call vundle#rc()

" ===========================================================================
" General bundles
" ===========================================================================

" Manage vundle with vundle
Bundle 'gmarik/vundle'

" Snipmate, dependencies and snippets
Bundle 'tomtom/tlib_vim'              , {'name': 'tlib'}
Bundle 'MarcWeber/vim-addon-mw-utils' , {'name': 'markweber-utils'}
Bundle 'garbas/vim-snipmate'          , {'name': 'snipmate'}
Bundle 'westcave/snipmate-snippets'

Bundle 'tpope/vim-abolish'                , {'name': 'abolish'}
Bundle 'mileszs/ack.vim'                  , {'name': 'ack'}
Bundle 'Align'                            , {'name': 'align'}
Bundle 'vim-scripts/Arduino-syntax-file'  , {'name': 'arduino-syntax-file'}
Bundle 'tpope/vim-bundler'                , {'name': 'bundler'}
Bundle 'camelcasemotion'                  , {'name': 'camelcasemotion'}
Bundle 'kchmck/vim-coffee-script'         , {'name': 'coffeescript'}
Bundle 'Conque-Shell'                     , {'name': 'conque-shell'}
Bundle 'Color-Scheme-Explorer'            , {'name': 'cs-explorer'}
Bundle 'kien/ctrlp.vim'                   , {'name': 'ctrlp'}
Bundle 'tpope/vim-cucumber'               , {'name': 'cucumber'}
Bundle 'tpope/vim-endwise'                , {'name': 'endwise'}
Bundle 'tpope/vim-fugitive'               , {'name': 'fugitive'}
Bundle 'tpope/vim-git'                    , {'name': 'git'}
Bundle 'tpope/vim-haml'                   , {'name': 'haml'}
Bundle 'michaeljsmith/vim-indent-object'  , {'name': 'indent_object'}
Bundle 'wgibbs/vim-irblack'               , {'name': 'irblack'}
Bundle 'pangloss/vim-javascript'          , {'name': 'javascript'}
Bundle 'hallison/vim-markdown'            , {'name': 'markdown'}
Bundle 'matchit.zip'                      , {'name': 'matchit'}
Bundle 'scrooloose/nerdcommenter'         , {'name': 'nerdcommenter'}
Bundle 'xolox/vim-notes'                  , {'name': 'notes'}
Bundle 'ajf/puppet-vim'                   , {'name': 'puppet'}
Bundle 'pylint.vim'                       , {'name': 'pylint'}
Bundle 'python.vim--Vasiliev'             , {'name': 'python-syntax'}
Bundle 'tpope/vim-rails'                  , {'name': 'rails'}
Bundle 'tpope/vim-repeat'                 , {'name': 'repeat'}
Bundle 'taq/vim-rspec'                    , {'name': 'rspec'}
Bundle 'ShowMarks'                        , {'name': 'showmarks'}
Bundle 'altercation/vim-colors-solarized' , {'name': 'solarized'}
Bundle 'jdevera/vim-stl-syntax'           , {'name': 'stl-syntax'}
Bundle 'ervandew/supertab'                , {'name': 'supertab'}
Bundle 'tpope/vim-surround'               , {'name': 'surround'}
Bundle 'scrooloose/syntastic'             , {'name': 'syntastic'}
Bundle 'majutsushi/tagbar'                , {'name': 'tagbar'}
Bundle 'vim-scripts/taglist.vim'          , {'name': 'taglist'}
Bundle 'vim-scripts/searchfold.vim'       , {'name': 'searchfold'}
Bundle 'timcharper/textile.vim'           , {'name': 'textile'}
Bundle 'davidoc/todo.txt-vim'             , {'name': 'todo-txt'}
Bundle 'tpope/vim-unimpaired'             , {'name': 'unimpaired'}
Bundle 'jpalardy/vim-slime'               , {'name': 'vim-slime'}
Bundle 'tpope/vim-vividchalk.git'         , {'name': 'vividchalk'}
Bundle 'vim-scripts/ZoomWin'              , {'name': 'zoomwin'}
" Load additional local bundles. The local/bundles.vim file, if it exists,
" contains Bundle specs that make sense only in the current machine. That file
" is not tracked. See also the *Local configurations* section below.
if filereadable(expand('~/.vim/local/bundles.vim'))
    execute 'source ' . expand('~/.vim/local/bundles.vim')
endif

" }}}
" {{{ Behaviour?
" ----------------------------------------------------------------------------

" load all autocommands only once
au!

" Set encoding
set encoding=utf-8

" Shows autocomplete menu for commands
set wildmenu

"Completion list settings
" First time tab is hit, complete the longest common string
" Second time tab is hit, list all possible matches
set wildmode=list:longest,list:full

"Add additional suffixes to the default (to be ignored)
set suffixes+=,.class,.swp

"Don't tab complete files with these extensions
set wildignore=*.class,*.swp,*.o,*.pyc,*.obj,.git,*.rbc,*.svn,*/tmp/*,tmp\*,*.so,*.zip,*.exe

" Look for tag files in the same directory of the edited file, and all the way
" up to the root directory (hence the ;)
set tags=./tags;,tags

" Also allow to specify the tags file location through the environment
if $TAGS_DB != "" && filereadable($TAGS_DB)
    set tags+=$TAGS_DB
endif

"Keep cursor in same column when jumping from file to file
set nostartofline

" Set a pdf printer as default printer
set printdevice=pdfprinter

" New windows (vsplit) on the right of the current one
set splitright

" New windows (split) below the current one
set splitbelow

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=4

" Wrapped lines don't look good when coding
set nowrap

function s:setupMarkup()
  set wrap
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" Arduino
autocmd! BufNewFile,BufRead *.{pde,ino} setlocal ft=arduino

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt set wrap

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set modeline
set modelines=10

" Move lines or blocks of text using Alt-jkhl
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
nnoremap <C-h> <<
nnoremap <C-l> >>
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
inoremap <C-h> <Esc><<`]a
inoremap <C-l> <Esc>>>`]a
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
vnoremap <C-h> <gv
vnoremap <C-l> >gv

" * stays on current word match
" * removes current search
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> * Highlighting()

" <CR> clears search hilighting
nnoremap <CR> :noh<CR>

" exit insert mode after 5 seconds of inactivity
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=5000
au InsertLeave * let &updatetime=updaterestore

" easier to get into command mode
nnoremap ; :

" " easy escape for non-remapped keyboards (hopefully no kj words)
inoremap kj <Esc>
cnoremap kj <Esc>  

" " move up and down wrapped lines rather than actual lines
noremap j gj
noremap k gk

set visualbell

" ----------------------------------------------------------------------------
" }}}
" {{{ Spacing
" ----------------------------------------------------------------------------

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2

" Number of spaces to use for each step of (auto)indent
set shiftwidth=2

set softtabstop=2

" A <Tab> in front of a line inserts blanks according to shiftwidth
" A <BS> deletes shiftwidth spaces at the start of the line
set smarttab

" Set auto indent, most of the time it annoys me not to have, so I will
" disable it on demand
set autoindent

" Converts tabs into spaces
set expandtab

" In insert mode, allows the backspace key to erase previously entered
" characters
" :help 'backspace'
set backspace=indent,eol,start

" Set the caracters to use when showing tabs and trailing spaces with
" :set list
" Ctrl-K >> for » and Ctrl-K .M for ·  (use :dig for list of digraphs)
set listchars=tab:»»,trail:·

" ----------------------------------------------------------------------------
" }}}
" {{{ Appearance
" ----------------------------------------------------------------------------

syntax enable
set background=dark
silent! colorscheme solarized
if has('win32') || has('win64')
  set guifont=Lucida\ Console:h12
elseif has('macunix')
  set guifont=Droid\ Sans\ Mono:h16
elseif has('unix')
  set guifont=Droid\ Sans\ Mono\ 11
endif

" Remove the GUI tool bar (I can't recall having ever used it)
if has("gui_running")
    set guioptions-=T
endif

" Allow the use of colors for themes
if &term =~ '^\(xterm\|screen\|xterm-color\)$'
    set t_Co=256
endif

" Show line numbers
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set ruler

" Highlight search terms
set hlsearch

" Show matching brackets
set showmatch

" Show (partial) command in status line
set showcmd

" Shows the mode (INSERT, VISUAL, REPLACE) in the status bar
" Enabled by default in vim.
" set showmode " Overridden by custom statusline


" Long line indicators
set listchars+=precedes:<,extends:>


" Use a fixed status line that is always visible
set laststatus=2

" Control what information is shown in the status line
" ----------------------------------------------------
" Short version for diffs, to make sure the file name is visible:
"   - Cursor position within the file (row, column)
"   - Percentage of the file where the cursor is now
"   - File length in lines
"   - Path to file
"
" Long version for regular editing:
"   - Newline format (Unix, Windows, Mac)
"   - File type (as recognised by vim, e.g. for syntax highlight)
"   - The ASCII value of the character under the cursor (only in normal mode)
"   - HEX for the ASCII value in the previous field
"   - Cursor position within the file (row, column)
"   - Percentage of the file where the cursor is now
"   - File length in lines
" ----------------------------------------------------
if &diff
    set statusline=[POS=%04l,%04v][%p%%]\ [LEN=%L]\ [F=%F%m%r%h%w]
else
    "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
    " set statusline=%F%m%r%h%w\ [F=%{&ff}][T=%Y][C=%04v][L=%04l/%04L][%p%%]
    set statusline=%F%m%r%h%w
endif
" -----------------------------------------------

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" ----------------------------------------------------------------------------
" }}}
" {{{ Key mapping
" ----------------------------------------------------------------------------

" Set , as the map leader (The default \ is hard to type in Spanish keyboards)
let mapleader = ","

" F5 toggles the TagList window (plugin needed)
" N.B.: Although I'd prefer to use C-F3 for this, this key cobination doesn't
"       work when vim is run in gnome-terminal.
silent nnoremap <F5> :TlistToggle<CR>

" Shift+Tab shows the list of jumps in the tag stack.
nmap  <C-Tab>  :tags<CR>

" Open the definition in a new tab
nmap <A-/> :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>

" Open the definition in a vertical split
nmap <A-]> :vsp <CR>:exec("tjump ".expand("<cword>"))<CR>

" Offer a choice of tags when several match, jump directly if there is only
" one match.
noremap <C-]> g<C-]>

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> on o<Esc>
nnoremap <silent> On O<Esc>

" Use space to toggle folds
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Quickly open this file in a split
nmap <Leader>rc :bot split ~/.vimrc<CR>

" Quickly add a new spelling abbreviation to this file.
nmap <F6> :bot split ~/.vimrc<CR>G?LAST_SPELL<CR>zRkoiab<Space>
nmap <C-F6> :let tmp=@f<CR>"fyaw<Esc>:bot split ~/.vimrc<CR>G?LAST_SPELL<CR>zRkoiab<Space><Esc>"fp<Esc>:let @f=tmp<CR>a<Space>

" Split jumping
map <right> :wincmd l<CR>
map <left> :wincmd h<CR>
map <up> :wincmd k<CR>
map <down> :wincmd j<CR>

" Make shift insert work in the gui as it does in the shell.
if has('gui_running')
    silent noremap! <S-Insert> <MiddleMouse>
endif

" Diff operations made shorter (Great for merges)
if &diff
    nnoremap <Leader>du  :diffupdate<cr>
    nnoremap <Leader>dg  :diffget<cr>
    nnoremap <Leader>dp  :diffput<cr>
    nnoremap <Leader>dg1 :diffget 1<cr>
    nnoremap <Leader>dg2 :diffget 2<cr>
    nnoremap <Leader>dg3 :diffget 3<cr>
endif

" ----------------------------------------------------------------------------
" }}}
" {{{ Cscope
" ----------------------------------------------------------------------------

if has("cscope")
    if $CSCOPE_BIN != ""
        set csprg=$CSCOPE_BIN
    endif
    set csto=0
    " set cst  " Map all the tag lookups to cscope
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        if filereadable($CSCOPE_DB)
            cs add $CSCOPE_DB
        endif
    endif
    set csverb

    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " displays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "


    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (interpreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
else
    echo "No cscope"
endif

" ----------------------------------------------------------------------------
" }}}
" {{{ Abbreviations
" ----------------------------------------------------------------------------
iab ddate <C-R>=strftime("%Y-%m-%d")<CR>

" {{{ Usual spelling mistakes
" ---------------------------
iab teh         the
iab becuase     because
iab defualt     default
iab Defualt     Default
iab whould      should
iab Whould      Should
" LAST_SPELL (this is a marker for quick search)
" ---------------------------
" }}}

" ----------------------------------------------------------------------------
" }}}
" {{{ Plugin configuration
" ----------------------------------------------------------------------------


" Tasklist: List of markers for tasks
let g:tlTokenList = ['\<TODO\>', '\<FIXME\>', '\<QUESTION\>', '\<HACK\>', '\<XXXJDV\>']

" NERDCommenter: Add a space after the comment symbol
let NERDSpaceDelims=1

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" TagList: Generate tags even if the TList window is closed.
let Tlist_Process_File_Always = 1

" TagList: Display tags defined only in the current buffer.
let Tlist_Show_One_File = 1

" TagList: Close Vim if the taglist is the only window.
let Tlist_Exit_OnlyWindow = 1

" SqlCompletion: disable generated maps, they are annoying!
let g:omni_sql_no_default_maps = 1

" ShowMarks: Disable on startup (will use it on demand)
let g:showmarks_enable = 0

" Pylint: Disable calling pylint automatically when saving
let g:pylint_onwrite = 0
"
" Tagbar: show the tag corresponding to the current cursor position
let g:tagbar_autoshowtag = 1

" Tagbar: map <F9> to toggle tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>

" VimNotes: Set notes dir in dropbox
if $DDROPBOX != "" && isdirectory($DDROPBOX)
    let g:notes_directory=$DDROPBOX . "/vimnotes"
    let g:notes_shadowdir=g:notes_directory . "/shadow"
endif

" Doxygen: Autoload doxygen highlighting
let g:load_doxygen_syntax = 1

" Snipmate: My name for Snippets
if $MYFULLNAME != ""
    let g:snips_author=$MYFULLNAME
endif

" Unimpaired
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if os == "osx"
  let g:gist_clip_command = 'pbcopy'
elseif os == "unix" 
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" clipboard compatibility
if has("clipboard")
  set clipboard=unnamed
else
  if os == "osx"
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><CR>
  elseif os == "unix"
    vmap <C-x> :!xclip -selection clipboard<CR>
    vmap <C-c> :w !xclip -selection clipboard<CR><CR>
  endif
end

" Ctrlp
" let g:ctrlp_working_path_mode = 0 "don't manage working directory
let g:ctrlp_max_height = 40
let g:ctrlp_max_files = 0

" ZoomWin
map <Leader><Leader> :ZoomWin<CR>

" Slime
let g:slime_target = "tmux"

" ----------------------------------------------------------------------------
" }}}
" {{{ Local configuration

" Load local settings. 
" Warning: Additional Bundles should not be included in this file, use the
"          local/bundles.vim file instead.
if filereadable(expand('~/.vim/local/.vimrc'))
    execute 'source ' . expand('~/.vim/local/.vimrc')
endif

" }}}
" {{{ Experimental area
" ----------------------------------------------------------------------------

" The whole experimental area can be disabled by running vim as vine or gvine.
" (Create symbolic links or copy the executable file)
if v:progname != "vine" && v:progname != "gvine"

  " {{{ HEX mode function and command
  " ----------------------------------------------------------------------------
  "
  " helper function to toggle hex mode
  function! ToggleHex()
      " ---------------------------------------------------------------
      " hex mode should be considered a read-only operation
      " save values for modified and read-only for restoration later,
      " and clear the read-only flag for now
      " ---------------------------------------------------------------
      let l:modified=&mod
      let l:oldreadonly=&readonly
      let &readonly=0
      let l:oldmodifiable=&modifiable
      let &modifiable=1
      " ---------------------------------------------------------------

      if !exists("b:editHex") || !b:editHex

          " save old options
          let b:oldft=&filetype
          let b:oldbin=&binary

          " set new options
          setlocal binary " make sure it overrides any textwidth, etc.
          let &ft="xxd"

          " set status
          let b:editHex=1

          " switch to hex editor
          %!xxd

      else

          " restore old options
          let &filetype=b:oldft
          if !b:oldbin
            setlocal nobinary
          endif

          " set status
          let b:editHex=0

          " return to normal editing
          %!xxd -r

      endif

      " ---------------------------------------------------------------
      " restore values for modified and read only state
      " ---------------------------------------------------------------
      let &mod=l:modified
      let &readonly=l:oldreadonly
      let &modifiable=l:oldmodifiable
      " ---------------------------------------------------------------
  endfunction
  "
  " Command to call the above function, can be used directly in normal mode
  command! -bar Hexmode call ToggleHex()
  "
  "
  " ----------------------------------------------------------------------------
  " }}}

  " Create specific settings depending on the calling program name
  if v:progname == "vimm"
      color morning
  endif

  " TODO: This should only be set for rst or text files
  nmap <Leader>ti yyPVr=yyjpo<CR>
  nmap <Leader>h1 yypVr=o<CR>
  nmap <Leader>h2 yyrVr-o<CR>
  nmap <Leader>h3 yypVr~o<CR>

  "TODO: This should probably be set somewhere else.
  augroup experiment

      au!
      autocmd FileType python compiler pylint

      " When opening a file, go to the last known position when the file was last
      " open.
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  augroup END

  " Reload this configuration file automatically when it is changed within Vim
  " augroup myvimrc
  "     au!
  "     au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') && !empty($MYGVIMRC) | so $MYGVIMRC | endif
  " augroup END

  " Function and command to open a tag in a new tab (I'm always doing this
  " manually).
  function! Tabtag(word)
      echo a:word
      tab split
      exec "tjump " . a:word
  endfunction
  command! -nargs=1 -complete=tag Tag call Tabtag("<args>")
  
  function! KillRockets()
    silent! %s/\m:\(\w\+\)\s\+=>\s\+['"]\{1}\([^'"]*\)['"]\{1}/\1: "\2"/g
    silent! %s/\m:\(\w\+\)\s\+=>\s\+\([^'"]\+\)/\1: \2/g
  endfunction

endif
" ----------------------------------------------------------------------------
" }}}
" vim:fdm=marker:et:ts=4:

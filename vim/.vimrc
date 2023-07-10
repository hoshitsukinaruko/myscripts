" Basic Settings
set nu " 顯示行號
set rnu " 顯示相對行號
set ai " 自動對齊縮排
set cursorline " 光標底線
set bg=dark " 暗色背景
set tabstop=2 " 縮排間隔數
set shiftwidth=2 " 自動縮排對齊間隔數
filetype indent on " 啟用依照檔案類型決定自動縮排樣式的功能
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE " 設定行號為：粗體，前景色為深灰色，沒有背景色
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE " 設定游標所在的行號為：粗體，前景色為綠色，沒有背景色
set encoding=utf8 " UTF8
syntax enable " 語法上色
set showmatch " 顯示括號配對情況
set t_Co=256
set laststatus=0
set noshowmode
set noruler
set noshowcmd
packadd! doki-theme
colorscheme nakano_miku

if filereadable(expand("~/.vim/plugin.vim"))
  source ~/.vim/plugin.vim
endif
if filereadable(expand("~/.config/nvim/plugin.vim"))
  source ~/.local/share/nvim/plugin.vim
endif


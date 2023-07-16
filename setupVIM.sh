#!/bin/bash
function has_command() {
  command -v $1 >/dev/null
}

# CustomOutput
function customOutput {
  figlet -f banner -kc $1 | lolcat
}

# When no figlet and lolcat
# colors
CDEF=" \033[0m"      # default color
CCIN=" \033[0;36m"   # info color
CGSC=" \033[0;32m"   # success color
CRER=" \033[0;31m"   # error color
CWAR=" \033[0;33m"   # warning color
b_CDEF=" \033[1;37m" # bold default color
b_CCIN=" \033[1;36m" # bold info color
b_CGSC=" \033[1;32m" # bold success color
b_CRER=" \033[1;31m" # bold error color
b_CWAR=" \033[1;33m"
# echo like ...  with  flag type  and display message  colors
prompt() {
  case ${1} in
  "-s" | "--success")
    echo -e "${b_CGSC}${@/-s/}${CDEF}"
    ;; # print success message
  "-e" | "--error")
    echo -e "${b_CRER}${@/-e/}${CDEF}"
    ;; # print error message
  "-w" | "--warning")
    echo -e "${b_CWAR}${@/-w/}${CDEF}"
    ;; # print warning message
  "-i" | "--info")
    echo -e "${b_CCIN}${@/-i/}${CDEF}"
    ;; # print info message
  *)
    echo -e "$@"
    ;;
  esac
}

if has_command figlet && has_command lolcat; then
  customOutput "Set up vim"
fi
prompt -i "Setting up vim..."

if command -v nvim; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  mkdir -p ~/.config/nvim
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/.vimrc --output ~/.config/nvim/init.vim --silent
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/coc-config.vim --output ~/.config/nvim/coc-config.vim --silent
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/plugin.vim --output ~/.config/nvim/plugin.vim --silent
  ln -s ~/.config/nvim/plugin.vim ~/.local/share/nvim/plugin.vim
  mkdir -p ~/.local/share/nvim/site/pack/themes/start
  git clone https://github.com/doki-theme/doki-theme-vim.git ~/.local/share/nvim/site/pack/themes/start/doki-theme
else
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  mkdir -p ~/.vim
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/.vimrc --output ~/.vimrc --silent
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/coc-config.vim --output ~/.vim/coc-config.vim --silent
  curl https://raw.githubusercontent.com/naruko-hstk/myscripts/master/vim/plugin.vim --output ~/.vim/plugin.vim --silent
  mkdir -p ~/.vim/pack/themes/start
  git clone https://github.com/doki-theme/doki-theme-vim.git ~/.vim/pack/themes/start/doki-theme
fi
prompt -s "VIM setup complete!"

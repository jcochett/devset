echo "DevSet Installing"
mkdir -p ~/.vim/colors/ ~/.vim/compiler ~/.vim/plugin
echo "Copying .vimrc"
cp .vimrc      ~/.vimrc
echo "Copying vimcmd.txt reference"
cp vim-mem.txt ~/.vim/vim-mem.txt
echo "Copying vimhelp.txt for F2 help"
cp vimhelp.txt ~/.vim/vimhelp.txt
echo "Copying gruvbox to .vim/colors for colorscheme"
cp extras/gruvbox.vim ~/.vim/colors
echo "Copying pylint.vim to .vim/compiler for pylint in Quickfix lists"
cp extras/pylint.vim  ~/.vim/compiler

# Plugins
mkdir -p ~/.vim/plugin
echo "Setup chartab plugin: <SPACE>ct for ascii chart popup"
cp extras/chartab.vim ~/.vim/plugin

echo "Setup supertab plugin: <TAB> for autocomplete"
mkdir -p ~/.vim/pack/default/start/
tar -xzf extras/supertab.tar.gz -C ~/.vim/pack/default/start/

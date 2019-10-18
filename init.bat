set HOME=%HOMEDRIVE%%HOMEPATH%
mklink %HOME%\_vimrc %HOME%\.dotfiles\.vimrc
mklink %HOME%\_gvimrc %HOME%\.dotfiles\.gvimrc
mkdir %HOME%\.vim
mkdir %HOME%\.vim\vimSwap
mkdir %HOME%\.vim\vimBackUp
mkdir %HOME%\.vim\undo

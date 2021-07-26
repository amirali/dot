install:
	sudo dnf install vim kitty tmux cmake gcc-c++ make python3-devel golang nodejs npm
	cp -r .vim .vimrc .config ~/
	vim +PlugInstall +qa
	cd ~/.vim/plugged/YouCompleteMe
	./install --go-completer --clangd-completer --rust-completer --ts-completer

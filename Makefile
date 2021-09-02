OS = $(shell awk '/^ID=/' /etc/os-release | sed 's/ID=//' | sed 's/[.]0/./')

install:
ifeq ($(OS),fedora)
	sudo dnf install vim kitty tmux cmake gcc-c++ make python3-devel golang nodejs npm i3-gaps i3status fzf
else ifeq ($(OS),arch)
	sudo pacman -S vim kitty tmux cmake go nodejs npm i3-gaps i3status fzf
endif
	cp -r .vim .vimrc .config ~/
	vim +PlugInstall +qa
	cd ~/.vim/plugged/YouCompleteMe
	./install --go-completer --clangd-completer --rust-completer --ts-completer


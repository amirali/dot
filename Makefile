.PHONY: base

OS = $(shell awk '/^ID=/' /etc/os-release | sed 's/ID=//' | sed 's/[.]0/./')

base:
ifeq ($(OS),fedora)
	sudo dnf install vim kitty tmux cmake gcc-c++ make python3-devel golang fzf the_silver_searcher ripgrep yarn -y
else ifeq ($(OS),opensuse-tumbleweed)
	sudo zypper in vim kitty tmux cmake gcc-c++ python3-devel go fzf the_silver_searcher ripgrep yarn -y
else ifeq ($(OS),arch)
	sudo pacman -S vim kitty tmux cmake go fzf the_silver_searcher ripgrep yarn --noconfirm
else
	@echo OH NO! We don't do that here :))
	exit 0
endif
	cp -r .vimrc .config ~/
	vim +qa
	vim +PlugInstall +qa

i3:
ifeq ($(OS),fedora)
	sudo dnf install i3-gaps i3status i3lock feh -y
else ifeq ($(OS),arch)
	sudo pacman -S i3-gaps i3status i3lock feh --noconfirm
else
	@echo OH NO! We don't do that here :))
	exit 0
endif

all: base i3

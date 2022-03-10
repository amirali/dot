.PHONY: base

OS = $(shell awk '/^ID=/' /etc/os-release | sed 's/ID=//' | sed 's/[.]0/./')

base:
ifeq ($(OS),debian)
	sudo apt update
	sudo apt install neovim golang kitty cmake make python3-dev python3-pip ripgrep zsh curl -y
else ifeq ($(OS),fedora) # Fuck you dear Fedora
	sudo dnf install zsh vim kitty tmux cmake gcc-c++ make python3-devel golang fzf the_silver_searcher ripgrep yarn curl -y
else ifeq ($(OS),opensuse-tumbleweed)
	sudo zypper in zsh vim kitty tmux cmake gcc-c++ python3-devel go fzf the_silver_searcher ripgrep yarn curl -y
else ifeq ($(OS),arch)
	sudo pacman -S zsh vim kitty tmux cmake go fzf the_silver_searcher ripgrep yarn curl --noconfirm
else
	@echo OH NO! We don't do that here :))
	exit 0
endif
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git submodule update --init
	cp -r .config .oh-my-zsh .fonts .zshrc ~/
	nvim +PackerSync

lsp:
	# Python
	pip3 install jedi-language-server
	# Go
	go install golang.org/x/tools/gopls@latest
	# Rust
	mkdir -p ~/.local/bin
	curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer

rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

wasm-pack: rust
	curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

i3:
ifeq ($(OS),fedora)
	sudo dnf install i3-gaps i3status i3lock feh -y
else ifeq ($(OS),arch)
	sudo pacman -S i3-gaps i3status i3lock feh --noconfirm
else
	@echo OH NO! We don't do that here :))
	exit 0
endif

all: base lsp rust wasm-pack

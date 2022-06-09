# Path to oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"

# Theme
ZSH_THEME="bubble-gum"

COMPLETION_WAITING_DOTS="true"

plugins=(
    ansible
    git
    git-auto-fetch
    shell-proxy
    thefuck
    z
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    bgnotify
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
setopt INC_APPEND_HISTORY
source "${ZSH}/oh-my-zsh.sh"

if [ -f "$HOME/.cargo/env" ]; then
    source ~/.cargo/env
fi

export PATH=$HOME/go/bin:$HOME/.local/bin:$PATH

if [ "`uname -s`" = "Darwin" ]; then
	export PATH=/opt/homebrew/opt/python@3.10/bin:$PATH
	export PATH=/Users/amirali/Library/Python/3.10/bin:$PATH
fi

eval $(thefuck --alias)

if [ -f "$HOME/.profile" ]; then
    source $HOME/.profile
fi

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES


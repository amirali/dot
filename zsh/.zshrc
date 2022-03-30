# Path to oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"

# Theme
ZSH_THEME="bubble-gum"

COMPLETION_WAITING_DOTS="true"

plugins=(
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    bgnotify
    zsh-z
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
setopt INC_APPEND_HISTORY
source "${ZSH}/oh-my-zsh.sh"

if [ -f "$HOME/.cargo/env" ]; then
    source ~/.cargo/env
fi

export PATH=$HOME/go/bin:$HOME/.local/bin:$PATH

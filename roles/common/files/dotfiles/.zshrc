[ -f ~/.profile ] && source ~/.profile

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit"
ZSH_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# zinit light nullxception/roundy

zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light Aloxaf/fzf-tab

zinit light zsh-users/zsh-syntax-highlighting

zinit light zsh-users/zsh-autosuggestions

zinit light arzzen/calc.plugin.zsh

zinit snippet OMZP::command-not-found
zinit snippet OMZP::cp
zinit snippet OMZP::deno
zinit snippet OMZP::gh
zinit snippet OMZP::ssh
zinit snippet OMZP::git-auto-fetch
zinit ice as"completion"; zinit snippet OMZP::docker/completions/_docker
zinit ice as"completion"; zinit snippet OMZP::docker-compose/_docker-compose
zinit ice as"completion"; zinit snippet OMZP::pip/_pip

# zinit wait lucid for MichaelAquilina/zsh-autoswitch-virtualenv
# export AUTOSWITCH_FILE="venv"

zinit light MichaelAquilina/zsh-you-should-use

zinit ice pick"async.zsh" src"pure.zsh"; zinit light sindresorhus/pure

source "$ZSH_HOME/catppuccin-macchiato-zsh-syntax-highlighting.zsh"

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
# set -o vi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:git-checkout:*' sort false

alias ls='ls --color'
alias grep='grep --color'
alias l='ls -lFh'
alias ll='ls -l'
alias la='ls -lAFh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias tar='tar tf'
command -v bit >/dev/null && alias git=bit

eval "$(fzf --zsh)"

[ ! -d ~/.autoenv ] && git clone 'https://github.com/hyperupcall/autoenv' ~/.autoenv
source ~/.autoenv/activate.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

# Fuck Python & MacOS
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

function nvr() {
    args=()
    for element in $@; do
        echo $element
        if [[ -e $element ]]; then
            element="$(pwd)/$element"
            echo $element
        fi
        args+=("$element")
    done
    nvim --server "$NEOVIM_LISTEN_ADDRESS" --remote $args
}

if [[ -n $NEOVIM_LISTEN_ADDRESS ]]; then
    alias vim="nvr"
else
    alias vim=nvim
fi

export PATH=$PATH:~/.spicetify

alias download="aria2c -x 16 -s 16 -k 1M -c"

source ~/.profile
export ZSH="${HOME}/.oh-my-zsh"
[ ! -d "$ZSH" ] && git clone https://github.com/ohmyzsh/ohmyzsh.git --single-branch --depth 1 .oh-my-zsh

# Theme
ZSH_THEME="bubble-gum"

COMPLETION_WAITING_DOTS="true"

# Catppuccin ZSH syntax highlighting
source $ZSH/custom/plugins/zsh-syntax-highlighting/catppuccin_macchiato-zsh-syntax-highlighting.zsh

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

export DENO_INSTALL="/home/amirali/.deno"

if [ "`uname -s`" = "Darwin" ]; then
    export PATH=/opt/homebrew/opt/python@3.10/bin:$PATH
    export PATH=/Users/amirali/Library/Python/3.10/bin:$PATH
    export DENO_INSTALL="/Users/amirali/.deno"
fi

eval $(thefuck --alias)

if [ -f "$HOME/.profile" ]; then
    source $HOME/.profile
fi

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="$DENO_INSTALL/bin:$PATH"

export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.1.0/bin"

# Wasmer
export WASMER_DIR="/Users/amirali/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

alias djvanilla="cd `mktemp -d`; virtualenv venv; source venv/bin/activate; pip install django; django-admin startproject test_vanilla .; python manage.py startapp web"
alias infmiare="pushd ~/src/miare/infrastructure; anssh -user=root -inv=production_common.ini -inv=production_sah.ini -inv=production_pol.ini -inv=staging.ini; popd"
alias vim="nvim"

alias blumail="POP_SMTP_HOST=mail.bluprint.ir POP_SMTP_PORT=465 POP_SMTP_USERNAME=amirali@bluprint.ir POP_SMTP_PASSWORD= pop"

alias download="aria2c -x 16 -s 16 -k 1M -c"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export ANDROID_HOME="/home/amirali/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

export PATH="$PATH:/usr/local/go/bin"

alias cheat="cht.sh"

export PATH=$PATH:/Users/amirali/.spicetify

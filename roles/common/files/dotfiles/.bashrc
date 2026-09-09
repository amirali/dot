# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
eval -- "$(/usr/local/bin/starship init bash --print-full-init)"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export VISUAL="cursor"
export BROWSER="firefox"
export TERMINAL="ghostty"

alias ll='ls -lah --color=auto'
alias gs='git status'
alias vim='nvim'
alias y='yazi'
alias music='ncmpcpp'

alias django='uv run manage.py'

export PGPASSWORD=$(cat ~/.pgpass | cut -d: -f4)
export PGHOST="localhost"

# . ~/promptless.sh

alias shutdown="shutdown.sh"

eval "$(fzf --bash)"
export PATH="$PATH:$HOME/development/flutter/bin"
export PUB_HOSTED_URL=https://pub.myket.ir
export FLUTTER_STORAGE_BASE_URL=https://pub.myket.ir
export PATH="$HOME/dev/flutter/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PUB_HOSTED_URL=https://pub.myket.ir
export FLUTTER_STORAGE_BASE_URL=https://pub.myket.ir
export PATH="$HOME/dev/flutter/bin:$PATH"

function kill-port() {
	kill -9 $(lsof -nP -iTCP -sTCP:LISTEN | grep $1 | awk '{print $2}')
}

# instant history
shopt -s histappend
PROMPT_COMMAND+=("history -a")

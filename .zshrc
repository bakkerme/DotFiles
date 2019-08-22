export ANDROID_SDK=$HOME/Android/Sdk/

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/tooling/vendor/bin:$PATH
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=$(npm bin):$PATH
export PATH=$HOME/go/bin/:$PATH
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH

alias vim='nvim'
alias l='ls -lah'
alias gst='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gdf='git diff'

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
setopt append_history # append rather then overwrite
setopt extended_history # save timestamp
setopt inc_append_history # add history immediately after typing a command

source ~/DotFiles/git-prompt.sh

prefix=${HOME}/.npm-packages
export NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

precmd () { __git_ps1 "%~" "%s $ "  }

set -o PROMPT_SUBST
export PS1='%F{black}%1~%f  $ '

source ~/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.env
eval "$(direnv hook zsh)"

bindkey -v
export KEYTIMEOUT=1

[ -f ~/fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

export ANDROID_SDK=$HOME/Android/Sdk/

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/tooling/vendor/bin:$PATH
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=$(npm bin):$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH
export PATH=$PATH:/usr/local/go/bin:$PATH
export PATH=$HOME/sources/.bin:$PATH
export PATH=$HOME/snap/flutter/common/flutter/bin/cache/dart-sdk/bin:$PATH
export PATH=/usr/local/flutter/bin/:$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

export MOZ_ENABLE_WAYLAND=1

alias vim='nvim'
alias l='ls -lah --color'
alias gst='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gdf='git diff'
alias gpb='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'

alias setup_session_local='setup_session --server http://localhost --cacheRegion localhost'

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
setopt append_history # append rather then overwrite
setopt extended_history # save timestamp
setopt inc_append_history # add history immediately after typing a command
setopt hist_find_no_dups # Don't show duplicates in search
setopt hist_ignore_dups
setopt hist_ignore_space # Don't preserve spaces. You may want to turn it off
setopt no_hist_beep # don't beep
setopt share_history # share history between session/terminals

source ~/DotFiles/git-prompt.sh

prefix=${HOME}/.npm-packages
export NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

NEWLINE=$'\n'

# precmd () { __git_ps1 "%B%F{blue}%~%f%b" "%s %* ${NEWLINE}$ "  }
precmd() {
  local aws_vault_display=""
  if [[ -n "$AWS_VAULT" ]]; then
    aws_vault_display=" [vault:$AWS_VAULT] "
  fi
  __git_ps1 "%B%F{blue}%~%f%b" "${aws_vault_display}%s %* ${NEWLINE}$ "
}

set -o PROMPT_SUBST
# export PS1="%F{black}%1~%f  $"

source ~/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.env

bindkey -v
export KEYTIMEOUT=1

[ -f ~/fzf.zsh ] && source ~/.fzf.zsh # Repo version
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh # Arch repo
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh # Fedora
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh # Arch

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh # Fedora
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh # Arch repo


[ -f ./git-completion.zsh ] && zstyle ':completion:*:*:git:*' script ./git-completion.zsh
[ -f ~/DotFiles/helm-completion.zsh ] && source ~/DotFiles/helm-completion.zsh
[ -f ~/DotFiles/kubectl-completion.zsh ] && source ~/DotFiles/kubectl-completion.zsh

_direnv_hook() {
  trap -- '' SIGINT;
  eval "$("/usr/bin/direnv" export zsh)";
  trap - SIGINT;
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions=( _direnv_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z ${chpwd_functions[(r)_direnv_hook]} ]]; then
  chpwd_functions=( _direnv_hook ${chpwd_functions[@]} )
fi

export PATH=/home/brandon/.pyenv/versions/3.7.2/bin:$PATH

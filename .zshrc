export ANDROID_SDK=$HOME/Android/Sdk/

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/tooling/vendor/bin:$PATH
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=$(npm bin):$PATH
export PATH=$HOME/go/bin/:$PATH
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH
export PATH=$PATH:/usr/local/go/bin:$PATH
export PATH=$HOME/sources/.bin:$PATH

alias vim='nvim'
alias l='ls -lah --color'
alias gst='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gdf='git diff'
alias gpb='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpbu='git push upstream $(git rev-parse --abbrev-ref HEAD)'

alias setup_session_local='setup_session --server http://localhost --cacheRegion localhost'

SAVEHIST=9999
HISTFILE="$HOME/.zsh_history"
setopt append_history # append rather then overwrite
setopt extended_history # save timestamp
setopt inc_append_history # add history immediately after typing a command
setopt hist_find_no_dups # Don't show duplicates in search
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

precmd () { __git_ps1 "%~" "%s $ "  }

set -o PROMPT_SUBST
export PS1='%F{black}%1~%f  $ '

source ~/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.env

bindkey -v
export KEYTIMEOUT=1

[ -f ~/fzf.zsh ] && source ~/.fzf.zsh # Repo version
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh # Arch repo
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh # Fedora
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh # Arch
[ -f ./git-completion.zsh ] && zstyle ':completion:*:*:git:*' script ./git-completion.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/sls.zsh ]] && . /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/slss.zsh ]] && . /home/brandon/sources/tile-game-lite-mode/node_modules/tabtab/.completions/slss.zsh

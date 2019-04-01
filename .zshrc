export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/tooling/vendor/bin:$PATH
export PATH=$HOME/.config/composer/vendor/bin:$PATH
export PATH=$(npm bin):$PATH
export PATH=$HOME/go/bin/:$PATH

alias vim='nvim'
alias l='ls -lah'

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

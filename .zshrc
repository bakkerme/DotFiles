# Resolve DotFiles root from this file (follows symlink: ~/.zshrc -> DotFiles/.zshrc)
DOTFILES="${${(%):-%x}:A:h}"
OS="$(uname -s)"

# WSL (Windows Terminal / Alacritty → Linux guest). uname is still "Linux".
if [[ -n "${WSL_DISTRO_NAME:-}" ]] || [[ -r /proc/version && "$(</proc/version)" == *[Mm]icrosoft* ]]; then
  IS_WSL=1
else
  IS_WSL=0
fi

# Homebrew: Apple Silicon, Intel Mac, Linuxbrew (incl. WSL)
for _brew_prefix in /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
  if [[ -x "$_brew_prefix/bin/brew" ]]; then
    eval "$("$_brew_prefix/bin/brew" shellenv)"
    break
  fi
done
unset _brew_prefix

# Prefer existing ANDROID_SDK; common locations differ by host
if [[ -z "${ANDROID_SDK:-}" ]]; then
  for _sdk in "$HOME/Android/Sdk" "$HOME/Library/Android/sdk" "/mnt/c/Users/$USER/AppData/Local/Android/Sdk"; do
    if [[ -d "$_sdk" ]]; then
      export ANDROID_SDK="$_sdk"
      break
    fi
  done
  unset _sdk
fi
export ANDROID_SDK="${ANDROID_SDK:-$HOME/Android/Sdk}"

# Prepend only existing path entries (keeps PATH clean on machines missing a tool)
_path_prepend() {
  local p
  for p in "$@"; do
    [[ -d "$p" ]] || continue
    case ":$PATH:" in
      *":$p:"*) ;;
      *) PATH="$p${PATH:+:$PATH}" ;;
    esac
  done
}

_path_prepend \
  "$HOME/bin" \
  "/usr/local/bin" \
  "$HOME/.local/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/tooling/vendor/bin" \
  "$HOME/.config/composer/vendor/bin" \
  "$HOME/go/bin" \
  "${ANDROID_SDK}/emulator" \
  "${ANDROID_SDK}/tools" \
  "${ANDROID_SDK}/platform-tools" \
  "/usr/local/go/bin" \
  "$HOME/sources/.bin"

# PlatformIO virtualenv (if installed)
_path_prepend "$HOME/.platformio/penv/bin"

export PATH

# Wayland is Linux-native only (not macOS, not useful inside pure WSL GUIless sessions)
if [[ "$OS" == "Linux" && "$IS_WSL" -eq 0 ]]; then
  export MOZ_ENABLE_WAYLAND=1
fi

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"

# Truecolor hint for apps that check COLORTERM (Terminal.app, Windows Terminal, Alacritty, Ghostty)
export COLORTERM="${COLORTERM:-truecolor}"

alias vim='nvim'
# GNU ls uses --color; BSD ls (stock macOS) uses -G
if ls --color=auto / >/dev/null 2>&1; then
  alias l='ls -lah --color=auto'
else
  alias l='ls -lahG'
fi
alias gst='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gdf='git diff'
alias gpb='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'

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

[[ -f "$DOTFILES/git-prompt.sh" ]] && source "$DOTFILES/git-prompt.sh"

export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
_path_prepend "$NPM_PACKAGES/bin"
export PATH
# Prefer not to clobber a user-set MANPATH permanently; only extend if manpath exists
if command -v manpath >/dev/null 2>&1; then
  export MANPATH="$NPM_PACKAGES/share/man:$(manpath 2>/dev/null)"
fi

NEWLINE=$'\n'

precmd() {
  local aws_vault_display=""
  if [[ -n "${AWS_VAULT:-}" ]]; then
    aws_vault_display=" [vault:$AWS_VAULT] "
  fi
  if typeset -f __git_ps1 >/dev/null 2>&1; then
    __git_ps1 "%B%F{blue}%~%f%b" "${aws_vault_display}%s %* ${NEWLINE}$ "
  else
    PROMPT="%B%F{blue}%~%f%b${aws_vault_display} %* ${NEWLINE}$ "
  fi
}

set -o PROMPT_SUBST

[[ -f "$HOME/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$HOME/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -f "$HOME/.env" ]] && source "$HOME/.env"

bindkey -v
export KEYTIMEOUT=1

# fzf: prefer installer-generated file, then Homebrew, then distro packages
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
else
  for _fzf_dir in \
    ${HOMEBREW_PREFIX:+"$HOMEBREW_PREFIX/opt/fzf/shell"} \
    /usr/share/fzf/shell \
    /usr/share/fzf \
    /usr/share/doc/fzf/examples
  do
    if [[ -n "$_fzf_dir" && -f "$_fzf_dir/key-bindings.zsh" ]]; then
      source "$_fzf_dir/key-bindings.zsh"
      [[ -f "$_fzf_dir/completion.zsh" ]] && source "$_fzf_dir/completion.zsh"
      break
    fi
  done
  unset _fzf_dir
fi

# Git completion helper from this repo
if [[ -f "$DOTFILES/git-completion.zsh" ]]; then
  zstyle ':completion:*:*:git:*' script "$DOTFILES/git-completion.zsh"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# direnv: use whatever is on PATH (Homebrew, apt, scoop/WSL, etc.)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# eval `keychain --eval --agents ssh id_ed25519`

# >>> grok installer >>>
_path_prepend "$HOME/.grok/bin"
export PATH
if [[ -d "$HOME/.grok/completions/zsh" ]]; then
  fpath=("$HOME/.grok/completions/zsh" $fpath)
fi
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

unset -f _path_prepend
unset IS_WSL

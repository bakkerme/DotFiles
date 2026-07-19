#!/usr/bin/env bash
set -euo pipefail

# Resolve DotFiles directory from this script's location
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

echo "Installing DotFiles from: $DOTFILES"
echo "Detected OS: $OS"
if [[ -n "${WSL_DISTRO_NAME:-}" ]] || { [[ -r /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; }; then
  echo "Environment: WSL (${WSL_DISTRO_NAME:-unknown distro})"
  IS_WSL=1
else
  IS_WSL=0
fi
echo ""

install_deps_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed. Install it from https://brew.sh then re-run this script."
    echo "Required packages: zsh neovim tmux node the_silver_searcher fzf direnv"
    return 1
  fi

  echo "Installing dependencies with Homebrew..."
  brew install zsh neovim tmux node the_silver_searcher fzf direnv

  # fzf key bindings / completion (safe to re-run)
  if [[ -x "$(brew --prefix)/opt/fzf/install" ]]; then
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish || true
  fi
}

install_deps_linux() {
  echo "On Linux/WSL, install dependencies with your package manager, e.g.:"
  echo "  sudo apt install zsh neovim tmux nodejs npm silversearcher-ag fzf direnv"
  echo "Or run: ./aptinstall.sh (for the fuller apt set)"
  echo ""
  if [[ -t 0 ]]; then
    read -r -p "Press Enter to continue with config install (or Ctrl-C to abort)... "
  fi
}

case "$OS" in
  Darwin)
    if [[ -t 0 ]]; then
      read -r -p "Install/update Homebrew packages? [Y/n] " ans
    else
      ans=n
    fi
    case "${ans:-Y}" in
      [Yy]*|"") install_deps_macos ;;
      *) echo "Skipping package install." ;;
    esac
    ;;
  Linux)
    install_deps_linux
    ;;
  *)
    echo "Unsupported OS: $OS"
    echo "Make sure you install: zsh, neovim, tmux, node, npm, ag (the_silver_searcher), fzf, direnv"
    if [[ -t 0 ]]; then
      read -r -p "Press Enter to continue with config install... "
    fi
    ;;
esac

mkdir -p "$HOME/sources"
mkdir -p "$HOME/.npm-packages"

# git
git config --global user.email "brandon@bdmd.com.au"
git config --global user.name "Brandon Bakker"

# tmux
ln -sfn "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "tpm already installed, skipping clone."
fi

# zsh
touch "$HOME/.zsh_history"
ln -sfn "$DOTFILES/.zshrc" "$HOME/.zshrc"
if [[ ! -d "$HOME/sources/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/sources/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed, skipping clone."
fi

# neovim
mkdir -p "$HOME/.config/nvim"
ln -sfn "$DOTFILES/init.lua" "$HOME/.config/nvim/init.lua"

touch "$HOME/.env"

if command -v npm >/dev/null 2>&1; then
  npm config set prefix="$HOME/.npm-packages"
else
  echo "npm not found; skipped npm prefix config."
fi

# Alacritty (XDG path works on macOS, Linux, and WSL if you run it there)
mkdir -p "$HOME/.config/alacritty"
ln -sfn "$DOTFILES/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
echo "Alacritty: linked ~/.config/alacritty/alacritty.toml"
if [[ "$IS_WSL" -eq 1 ]]; then
  echo "  Windows host: also copy/import alacritty.windows.toml into %APPDATA%\\alacritty\\"
  echo "  (native Windows Alacritty launches WSL; this Linux path is only for Linux-side Alacritty)"
fi

# Ghostty (macOS GUI; Linux native). Skip noise on pure WSL unless present.
if [[ "$OS" == "Darwin" || ( "$OS" == "Linux" && "$IS_WSL" -eq 0 ) ]]; then
  mkdir -p "$HOME/.config/ghostty"
  ln -sfn "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
  echo "Ghostty: linked ~/.config/ghostty/config"
  if [[ "$OS" == "Darwin" ]]; then
    mac_ghostty="$HOME/Library/Application Support/com.mitchellh.ghostty"
    mkdir -p "$mac_ghostty"
    # Prefer config.ghostty name used by recent Ghostty builds
    ln -sfn "$DOTFILES/ghostty/config" "$mac_ghostty/config.ghostty"
    echo "Ghostty (macOS): linked $mac_ghostty/config.ghostty"
  fi
fi

# macOS: ensure Homebrew zsh is available as a login shell option
if [[ "$OS" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
  brew_zsh="$(brew --prefix)/bin/zsh"
  if [[ -x "$brew_zsh" ]]; then
    if ! grep -qF "$brew_zsh" /etc/shells 2>/dev/null; then
      echo "To use Homebrew zsh as your default shell, run:"
      echo "  echo '$brew_zsh' | sudo tee -a /etc/shells"
      echo "  chsh -s '$brew_zsh'"
    fi
  fi
fi

# Windows Terminal (WSL): print pointer to fragment
if [[ "$IS_WSL" -eq 1 ]]; then
  echo ""
  echo "Windows Terminal: merge profiles from:"
  echo "  $DOTFILES/windows-terminal.fragment.json"
  echo "into your Windows Terminal settings (Settings → Open JSON file), or copy the profile block."
fi

echo ""
echo "Done. Restart your shell or run: source ~/.zshrc"
echo "Terminal matrix:"
echo "  macOS Ghostty     — full CSI-u keybinds + theme auto light/dark"
echo "  macOS Terminal.app — shell/tmux/nvim OK; limited modified-key support"
echo "  Windows Terminal  — use WSL profile; truecolor OK; CSI-u limited"
echo "  Alacritty         — shared toml; Windows host needs alacritty.windows.toml"

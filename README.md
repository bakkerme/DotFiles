# DotFiles

Cross-platform shell and editor configs for **macOS** (Ghostty + Terminal.app) and **Windows** (Windows Terminal / Alacritty → WSL).

Core stack: **zsh**, **tmux**, **Neovim**, **fzf**, **direnv**.

## What’s included

| Path | Purpose |
|------|---------|
| `.zshrc` | Portable zsh (Homebrew, WSL-aware PATH, fzf, nvm, git prompt) |
| `.tmux.conf` | Prefix `C-s`, truecolor, CSI-u extended keys, TPM plugins |
| `init.lua` | Neovim (lazy.nvim, LSP, themes, WSL clipboard via win32yank) |
| `ghostty/config` | Ghostty theme + Grok-friendly CSI-u keybinds |
| `alacritty.toml` | Shared Alacritty (colors, font, CSI-u bindings) |
| `alacritty.windows.toml` | Windows host → launch WSL zsh |
| `windows-terminal.fragment.json` | Windows Terminal profile snippet |
| `install.sh` | Symlink configs + clone TPM / syntax highlighting |

Linux desktop extras (`swayconfig`, `i3blocks`, `foot.ini`, `keyd`, monitor scripts) are optional and not required on Mac/Windows.

## Quick install

Clone anywhere (symlink resolution does not require `~/DotFiles`):

```bash
git clone <this-repo> ~/DotFiles
cd ~/DotFiles
./install.sh
```

Then restart the shell, or:

```bash
source ~/.zshrc
```

Inside a new tmux session, install TPM plugins with **prefix + I** (`C-s` then `I`).

### Dependencies

**macOS (Homebrew)** — `install.sh` can install these:

```text
zsh neovim tmux node the_silver_searcher fzf direnv
```

**Linux / WSL**:

```bash
sudo apt install zsh neovim tmux nodejs npm silversearcher-ag fzf direnv
# or: ./aptinstall.sh
```

Optional but recommended:

- [Ghostty](https://ghostty.org) on macOS (best modified-key support)
- Font: **Iosevka Term** (or change the font in Alacritty / Windows Terminal)
- `win32yank.exe` on the Windows PATH for Neovim clipboard in WSL
- Local secrets / overrides: `~/.env` (created empty by install; sourced if present)

### Default shell (macOS)

Homebrew zsh is preferred when available:

```bash
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"
```

## Platform setup

### macOS — Ghostty

`install.sh` links:

- `~/.config/ghostty/config`
- `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`

Manual re-link if needed:

```bash
ln -sfn ~/DotFiles/ghostty/config \
  "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
```

Ghostty follows system light/dark themes and emits CSI-u sequences for Ctrl+., Shift+Enter, etc. (needed by Grok inside tmux).

### macOS — Terminal.app

Works for day-to-day shell, tmux, and Neovim. Modified keys (Ctrl+., Ctrl+Enter, Shift+Enter) are **limited** compared to Ghostty/Alacritty — use Ghostty when those chords matter.

### Windows — WSL (required for this zsh setup)

Run `./install.sh` **inside WSL**. Shell, tmux, and Neovim live in the Linux guest; the Windows terminal is only the UI.

### Windows — Windows Terminal

Merge the profile from `windows-terminal.fragment.json` into Windows Terminal settings (Settings → Open JSON file), or create a profile with:

```text
wsl.exe -e zsh -l
```

Font face: **Iosevka Term** (or adjust to a font you have installed).

### Windows — Alacritty (host → WSL)

1. Copy or symlink `alacritty.toml` to `%APPDATA%\alacritty\alacritty.toml`.
2. Import Windows shell overrides, e.g. in that file:

```toml
[general]
import = ["C:\\Users\\YOU\\path\\to\\DotFiles\\alacritty.windows.toml"]
```

`alacritty.windows.toml` sets:

```toml
[terminal.shell]
program = "wsl.exe"
args = ["-e", "zsh", "-l"]
```

Do **not** force `TERM=alacritty` unless the Alacritty terminfo is installed inside WSL (`infocmp alacritty`). Truecolor is handled via `COLORTERM`.

Legacy `alacritty.yml` is deprecated (Alacritty ≥ 0.13 uses TOML only).

## Terminal capability matrix

| Terminal | Shell / tmux / nvim | Truecolor | Ctrl+. / Shift+Enter (CSI-u) |
|----------|---------------------|-----------|------------------------------|
| macOS Ghostty | Full | Full | Full (config keybinds) |
| macOS Terminal.app | Full | Full | Limited |
| Windows Terminal → WSL | Full | Full | Limited vs Ghostty |
| Alacritty (Mac / Linux) | Full | Full | Full (toml bindings) |
| Alacritty (Windows → WSL) | Full with `alacritty.windows.toml` | Full | Full if bindings load |

## Layout after install

Symlinks created by `install.sh`:

```text
~/.zshrc              → DotFiles/.zshrc
~/.tmux.conf          → DotFiles/.tmux.conf
~/.config/nvim/init.lua → DotFiles/init.lua
~/.config/alacritty/alacritty.toml → DotFiles/alacritty.toml
~/.config/ghostty/config → DotFiles/ghostty/config   # macOS / Linux GUI
```

Also created if missing:

- `~/.tmux/plugins/tpm`
- `~/sources/zsh-syntax-highlighting`
- `~/.env`, `~/.zsh_history`, `~/.npm-packages`

## Everyday notes

- **tmux prefix**: `C-s` (not `C-b`)
- **Editor**: `nvim` (`vim` is aliased)
- **Git aliases**: `gst`, `gap`, `gcm`, `gdf`, `gpb`, `gpl`
- **Listing**: `l` (GNU `--color` or BSD `-G` as appropriate)
- **Themes**: Neovim auto light/dark via `auto-dark-mode.nvim`; Ghostty mirrors OS appearance
- **Extended keys**: Ghostty + Alacritty + tmux are wired for Grok-style chords; stock Terminal.app / many Windows Terminal profiles are not

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `unknown terminal type: alacritty` in WSL | Don’t force `TERM` in Alacritty env; or install Alacritty terminfo in WSL |
| Ctrl+. does nothing in tmux | Use Ghostty or Alacritty with the CSI-u keybinds; reload tmux config |
| Wrong shell inside tmux | Set login shell (`chsh`); tmux uses `$SHELL` |
| Neovim clipboard broken in WSL | Install `win32yank.exe` on the Windows PATH |
| Ghostty settings don’t apply | Ensure the Application Support `config.ghostty` symlink points at this repo |
| fzf keys missing | Re-run fzf install, or ensure Homebrew/distro fzf shell files exist |

## License

Personal dotfiles — use and fork freely.

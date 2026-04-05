# dotfiles
## setup
1. `~`にclone
2. `link.ps1` or `link.sh`を実行してシンボリックリンクを作成
3. powershellのセットアップは[PowerShell Setup](./powershell/README.md)を参照

## zsh
- install zsh: `sudo apt install zsh`
  - `chsh -s $(which zsh)`
- install starship: `curl -sS https://starship.rs/install.sh | sh`

## neovim
### windows
```sh
winget install Neovim.Neovim
```

### linux
```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
```

Add to `~/.zshenv`:
```sh
echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> ~/.zshenv
```

## memo
Q. `Cannot find package "tree-sitter-cli".`
A. `npm install -g tree-sitter-cli`が必要かも

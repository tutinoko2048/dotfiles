# dotfiles
## setup
1. `~`にclone
2. `link.ps1` or `link.sh`を実行してシンボリックリンクを作成
3. powershellのセットアップは[PowerShell Setup](./powershell/README.md)を参照

## zsh
- install zsh: `sudo apt install zsh`
  - `chsh -s $(which zsh)`
- install starship: `curl -sS https://starship.rs/install.sh | sh`
- install [eza](https://github.com/eza-community/eza) (better ls):
```sh
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

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

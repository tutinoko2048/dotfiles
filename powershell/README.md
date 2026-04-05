# PowerShell setup
```sh
winget install --id Microsoft.PowerShell --source winget
```

## install oh-my-posh
```
winget install JanDeDobbeleer.OhMyPosh -s winget
```

## install font
- https://fonts.google.com/specimen/IBM+Plex+Sans+JP
```
oh-my-posh font install meslo
```

## font settings
### Terminal
- `Cascadia Mono,MesloLGM Nerd Font,IBM Plex Sans JP`

### VSCode
- size: `13`
- family: `Cascadia Mono,MesloLGM Nerd Font,IBM Plex Sans JP`

## powershell config prepare
add to `$PROFILE`:
```
# カスタムプロファイルの読み込み
. $env:USERPROFILE\\.config\\powershell\\user_profile.ps1
```

## powershell utilities install
```
Install-Module posh-git -Scope CurrentUser -Force
Install-Module Terminal-Icons -Scope CurrentUser -Force
```

## powershell config
- set default shell to powershell
- create `User/.config/powershell/user_profile.ps1`
- copy `user_profile.ps1`, `omp.json`


## Install Scoop
```
iwr -useb get.scoop.sh | iex
```

## Install btop
```
scoop install btop
```

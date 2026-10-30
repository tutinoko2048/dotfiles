# Prompt
Import-Module posh-git

function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'omp.json'
oh-my-posh init pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Alias
# built-in aliases win over functions, so remove the ones we redefine
Remove-Item Alias:ls, Alias:gl, Alias:nv -Force -ErrorAction Ignore

if (Get-Command eza -CommandType Application -ErrorAction Ignore) {
  function ls { eza --icons=auto --group-directories-first @args }
  function ll { eza -la --icons=auto --group-directories-first --git @args }
  function lt { eza --tree --level=2 --icons=auto @args }
} else {
  Set-Alias ls Get-ChildItem
  function ll { Get-ChildItem -Force @args }
}

function gl { git pull @args }
function gs { git switch @args }
Set-Alias nv nvim

Set-Alias grep findstr
Set-Alias lg lazygit
Set-Alias vi nvim
Set-Alias vim nvim

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# https://github.com/antfu-collective/ni
if (-not (Test-Path $profile)) {
  New-Item -ItemType File -Path (Split-Path $profile) -Force -Name (Split-Path $profile -Leaf)
}

$profileEntry = 'Remove-Item Alias:ni -Force -ErrorAction Ignore'
$profileContent = Get-Content $profile
if ($profileContent -notcontains $profileEntry) {
  ("`n" + $profileEntry) | Out-File $profile -Append -Force -Encoding UTF8
}

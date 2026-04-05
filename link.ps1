Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }

$filesAndPaths = @(
  # common
  @{ Source = 'nvim'; Destination = '~/AppData/Local/nvim' }

  # windows
  @{ Source = 'powershell'; Destination = '~/.config/powershell' }
)

function Resolve-HomePath {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path
  )

  if ($Path -match '^~(?:/|$)') {
    return ($Path -replace '^~', $HOME)
  }

  return $Path
}

function New-SafeSymlink {
  param(
    [Parameter(Mandatory = $true)]
    [string]$SourceRelativePath,

    [Parameter(Mandatory = $true)]
    [string]$DestinationRawPath
  )

  $sourcePath = Join-Path $scriptRoot $SourceRelativePath
  if (-not (Test-Path -LiteralPath $sourcePath)) {
    throw "source not found: $sourcePath"
  }

  $resolvedSource = (Resolve-Path -LiteralPath $sourcePath).Path
  $destinationPath = Resolve-HomePath -Path $DestinationRawPath

  $destinationParent = Split-Path -Parent $destinationPath
  if (-not [string]::IsNullOrWhiteSpace($destinationParent) -and -not (Test-Path -LiteralPath $destinationParent)) {
    New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
  }

  if (Test-Path -LiteralPath $destinationPath) {
    $timestamp = Get-Date -Format 'yyyyMMddHHmmss'
    $backupPath = "$destinationPath.bak.$timestamp"
    Move-Item -LiteralPath $destinationPath -Destination $backupPath
  }

  New-Item -ItemType SymbolicLink -Path $destinationPath -Target $resolvedSource -Force | Out-Null
}

foreach ($entry in $filesAndPaths) {
  New-SafeSymlink -SourceRelativePath $entry.Source -DestinationRawPath $entry.Destination
}

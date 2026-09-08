<#
.SYNOPSIS
Loads the project build environment and declares its reusable build configuration.

.PARAMETER EnvironmentPath
Environment file selected by the first successful configuration initialization in the current PowerShell session. Start a fresh process to initialize from a different file.
#>
[CmdletBinding()]
param(
  [string]$EnvironmentPath = (Join-Path $PSScriptRoot '..\.env')
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot 'sharedVariants.ps1')
. (Join-Path $PSScriptRoot 'sharedBuild.ps1')

Import-BuildEnvironment -Path $EnvironmentPath

$repositoryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$Global:BuildSettings = @{
  WorkRoot = Join-Path $repositoryRoot '.work/build'
  PapyrusSourceRoot = Join-Path $repositoryRoot 'Papyrus'
  ScriptsDirectory = Join-Path $repositoryRoot '.work/build/scripts'
  ScaleformSourceRoot = Join-Path $repositoryRoot 'Scaleform'
  ScaleformDirectory = Join-Path $repositoryRoot '.work/build/scaleform'
}

$Global:ModuleVariants = @(
  [ModuleVariant]::new(
    'DEFAULT',
    'BOGUS Module',
    'BOGUS-BOGUS.esm',
    'BOGUS-BOGUS',
    'BOGUS:BOGUS',
    (Join-Path $repositoryRoot 'Staging'),
    'MODULE_DATABASE_PATH',
    @(),
    @(
      @{
        FileName = 'BOGUS-BOGUS - Main.ba2'
        Format = 'General'
        Compression = 'Default'
        MaxSizeMB = 2048
        IncludePapyrus = $true
        ExcludeFilters = '.*\\meta\.ini|.*\\.*\.dds|.*\\.*\.btc|.*\\.*\.esp|.*\\.*\.esm|.*\\.*\.ba2'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
      @{
        FileName = 'BOGUS-BOGUS - Textures.ba2'
        Format = 'DDS'
        Compression = 'Default'
        MaxSizeMB = 2048
        IncludePapyrus = $false
        IncludeFilters = '.*\\.*\.dds'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
      @{
        FileName = 'BOGUS-BOGUS - Main_XBox.ba2'
        Format = 'General'
        Compression = 'XBox'
        MaxSizeMB = 2048
        IncludePapyrus = $true
        ExcludeFilters = '.*\\meta\.ini|.*\\.*\.dds|.*\\.*\.btc|.*\\.*\.esp|.*\\.*\.esm|.*\\.*\.ba2'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
      @{
        FileName = 'BOGUS-BOGUS - Textures_XBox.ba2'
        Format = 'XBoxDDS'
        Compression = 'XBox'
        MaxSizeMB = 2048
        IncludePapyrus = $false
        IncludeFilters = '.*\\.*\.dds'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
      # Preserve the template's existing nominal PS names; these do not establish PS format support.
      @{
        FileName = 'BOGUS-BOGUS - Main_PS.ba2'
        Format = 'General'
        Compression = 'Default'
        MaxSizeMB = 2048
        IncludePapyrus = $true
        ExcludeFilters = '.*\\meta\.ini|.*\\.*\.dds|.*\\.*\.btc|.*\\.*\.esp|.*\\.*\.esm|.*\\.*\.ba2'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
      @{
        FileName = 'BOGUS-BOGUS - Textures_PS.ba2'
        Format = 'DDS'
        Compression = 'Default'
        MaxSizeMB = 2048
        IncludePapyrus = $false
        IncludeFilters = '.*\\.*\.dds'
        Assets = @(
          @{ Root = 'Staging'; Source = '.'; Target = '' }
        )
      }
    )
  )
)

$Global:SharedConfigurationLoaded = $true

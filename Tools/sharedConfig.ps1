# Replace the sample identity and add variants for the modules this repository owns.
. (Join-Path $PSScriptRoot 'sharedBuild.ps1')

$repositoryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$Global:BuildSettings = @{
  WorkRoot = Join-Path $repositoryRoot '.work/build'
  PapyrusSourceRoot = Join-Path $repositoryRoot 'Papyrus'
  ScriptsDirectory = Join-Path $repositoryRoot '.work/build/scripts'
  ScaleformSourceRoot = Join-Path $repositoryRoot 'Scaleform'
  ScaleformDirectory = Join-Path $repositoryRoot '.work/build/scaleform'
}

$sampleArchives = @(
  foreach ($platform in @(
    @{ Suffix = ''; TextureFormat = 'DDS'; Compression = 'Default' }
    @{ Suffix = '_XBox'; TextureFormat = 'XBoxDDS'; Compression = 'XBox' }
    # Preserve the template's existing nominal PS names; these are not PS format support.
    @{ Suffix = '_PS'; TextureFormat = 'DDS'; Compression = 'Default' }
  )) {
    @{
      FileName = "BOGUS-BOGUS - Main$($platform.Suffix).ba2"
      Format = 'General'; Compression = $platform.Compression; MaxSizeMB = 2048; IncludePapyrus = $true
      ExcludeFilters = '.*\\meta\.ini|.*\\.*\.dds|.*\\.*\.btc|.*\\.*\.esp|.*\\.*\.esm|.*\\.*\.ba2'
      Assets = @(@{ Root = 'Staging'; Source = '.'; Target = '' })
    }
    @{
      FileName = "BOGUS-BOGUS - Textures$($platform.Suffix).ba2"
      Format = $platform.TextureFormat; Compression = $platform.Compression; MaxSizeMB = 2048; IncludePapyrus = $false
      IncludeFilters = '.*\\.*\.dds'
      Assets = @(@{ Root = 'Staging'; Source = '.'; Target = '' })
    }
  }
)

$Global:ModuleVariants = @(
  [ModuleVariant]::new(
    'DEFAULT', 'BOGUS Module', 'BOGUS-BOGUS.esm', 'BOGUS-BOGUS',
    'BOGUS:BOGUS', (Join-Path $repositoryRoot 'Staging'), 'MODULE_DATABASE_PATH',
    @(),
    $sampleArchives
  )
)

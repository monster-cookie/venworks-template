# Venworks Template

Template for creating Starfield Creations using my workflow documented at [Workflow Documentation](https://github.com/monster-cookie/starfield-modding-notes/blob/master/Modding/Workflow.md)

## Instructions

1) Rename venworks-template.code-workspace to be what ever your repo is named for example in Venworks Core this file is named venworks-core.code-workspace.
2) Edit Tools\sharedConfig.ps1 and replace all occurrences of BOGUS with your namespace and creation name.
3) Create a .ENV file following the instructions in the workflow
4) Edit .github\workflows\package-release.yml and replace all occurrences of BOGUS with your namespace and creation name. Special note once you have manually deployed the package to nexus Mods (Creates the site and file IDs) you can set UPLOAD_TO_NEXUSMODS, make sure you have created GitHub Repository Variables for NEXUSMODS_API_KEY and NEXUSMODS_FILE_ID.
5) Update the README.md this is a weird file I sort of use it as mix of features, issues, and instructions.
6) When you are ready to release update MarketingSites\Nexus\moddetails.bbcode you pretty much need to edit the whole file.

Venworks Template is a reusable starting point for Starfield Creation repositories. It contains the shared Papyrus, Scaleform, Spriggit, staging, and BA2 pipeline entry points; a new Creation repository supplies its own configuration, source, manifests, and package choices.

## Pipeline contract

`Tools/sharedVariants.ps1` provides the reusable `ModuleVariant` model and selection helpers. `Tools/sharedConfig.ps1` is the template-owned configuration entrypoint that loads `.env` under the guarded session contract and publishes the template build values and variant definitions.

Each variant provides the following fields:

| Field | Purpose |
| --- | --- |
| `VariantKey` | Stable selector used by `-VariantKeys` and editor tasks. |
| `VariantName` | Human-readable name for logs and diagnostics. |
| `EsmFileName` | Explicit staged plugin filename used by authoring and packaging. |
| `PackageBaseName` | Base name used by configured package outputs. |
| `PapyrusNamespace` | Exact namespace directory owned by the variant; discovery stays inside this boundary. |
| `StagingFolderPath` | Repository path that becomes the junction for the variant. |
| `EnvironmentVariableName` | `.env` variable that names the physical staging destination. |
| `ScaleformBuilds` | Declarative movie and patch jobs; an empty list is valid for a Creation without Scaleform output. |
| `Archives` | Declarative archive format, compression, platform, filters, and output mappings. |

`Tools/sharedBuild.ps1`, `Tools/sharedVariants.ps1`, `Tools/sharedScaleform.ps1`, and `Tools/sharedPackaging.ps1` provide the generic environment, selection, namespace, movie, and archive helpers. The local entry points and repository configuration remain in this repository so a generated Creation repository can build independently without another repository checkout.

Scaleform job data identifies the job kind, input manifest or patch, output set, and output filenames. Archive entries use `FileName`, `Format`, `Compression`, `MaxSizeMB`, `IncludePapyrus`, optional filters, and `Assets` mappings with an explicit source root and archive target.

## Configure a new repository

Replace the placeholder values in `Tools/sharedConfig.ps1`, create the `Papyrus` and optional `Scaleform` source trees for the Creation, and prepare a local `.env` with the installed compiler, archiver, Spriggit, game, and physical destination paths required by the selected variants. Keep `.env` outside version control and resolve environment-derived destinations only after the entry point has loaded it.

Production entry points initialize `Tools/sharedConfig.ps1` through one guarded call per PowerShell session. It is the only required `.env` loader. The first successful initialization selects the requested `-EnvironmentPath`, and values from that file override inherited environment values. Later guarded calls reuse the initialized configuration; start a new `pwsh` process to select a different environment file. There is no skip flag or pure-configuration mode.

Do not add manually enumerated Papyrus source lists to a variant. Put owned `.psc` files below the configured namespace directory so compilation and packaging discover the same ownership boundary. A similarly named sibling namespace remains outside that package.

## Prepare staging

Fresh-checkout staging preparation is a maintainer operation. Remove or relocate any ordinary repository staging directory before running setup and preserve package files that are still needed. `Tools/setupRepo.ps1` creates a junction only when the configured repository path is absent and accepts an existing junction only when its target matches the configured environment destination. It does not empty, migrate, retarget, or repair an ordinary directory.

After preparing the physical destination and repository path, run the setup and check commands from the repository root:

```powershell
.\Tools\setupRepo.ps1
.\Tools\checkRepo.ps1
```

Use `-VariantKeys` with the configured keys when setting up or checking a subset. The setup operation is limited to junction creation; authoring and package migration remain explicit maintainer work.

## Build workflow

Run the entry points from the repository root in this order when the corresponding output is needed:

1. `.\Tools\compileScripts.ps1` discovers and compiles the selected namespace-owned Papyrus sources into the configured build output.
2. `.\Tools\buildScaleform.ps1` executes the selected `ScaleformBuilds` definitions. An empty definition set is valid and does not make Scaleform a required dependency.
3. `.\Tools\createPackages.ps1` validates selected ESM and build inputs, applies the configured `Archives` definitions, and publishes the resulting package files beneath verified staging junctions.

Omit `-VariantKeys` to process every configured variant or pass one or more configured keys to process a subset:

```powershell
.\Tools\compileScripts.ps1
.\Tools\buildScaleform.ps1
.\Tools\createPackages.ps1

.\Tools\compileScripts.ps1 -VariantKeys DEFAULT
.\Tools\createPackages.ps1 -VariantKeys DEFAULT
```

`DEFAULT` is the sample selector; its `BOGUS` identity must be replaced before the repository is used for a Creation. The pipeline does not copy code or runtime payloads from a foreign repository checkout, and its shared helpers do not require receipts, provenance files, or pinned external revisions.

The sample archives retain the established `Main`, `Textures`, `_XBox`, and nominal `_PS` filenames. The nominal `_PS` names preserve the template layout and do not claim PlayStation format or platform support.

Tagged release packaging consumes the configured `_PS` archive set, requires that set to be present before it builds the release ZIP, and copies those archive bytes into the release package. It preserves the established public release-name conversion by replacing the configured ` - ` separator with `_` without appending a second `_PS` suffix. This documents release source selection and filename routing only; it does not claim BA2 creation or platform acceptance.

## Spriggit authoring

Spriggit is an optional, developer-only authoring step. `Tools/SpriggitDumpDatabaseToYaml.ps1` serializes selected explicit `EsmFileName` values to their `Spriggit/<ESM>/` directories, and `Tools/SpriggitAssembleDatabaseFromYaml.ps1` assembles edited YAML back into the selected staged ESM. These commands are explicit authoring operations; compilation, Scaleform builds, packaging, and repository checks do not invoke them automatically.

Starfield does not execute Spriggit or read YAML at runtime. A runtime test consumes the ESM that a maintainer has authored or assembled and placed in the configured staging destination.

## Editor tasks and CI

The `.vscode/tasks.json` file exposes compile, Scaleform, setup, check, Spriggit, and package commands from the repository root. CI runs PowerShell analysis only; it does not claim native Papyrus, Scaleform, Archive2, Spriggit, Starfield, or target-console acceptance.

Run native tool builds and game or platform acceptance separately with the actual configured installations.

## Known boundaries

The template does not provide a product identity, gameplay behavior, runtime acceptance, or platform acceptance. Replace the placeholder configuration and add product-owned source and authoring data before treating a generated repository as buildable. Preserve the distinction between source-contract checks, native build results, package installation, game behavior, and platform acceptance when reporting results.

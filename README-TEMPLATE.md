# Venworks Template

Template for creating Starfield Creations using my workflow documented at [Workflow Documentation](https://github.com/monster-cookie/starfield-modding-notes/blob/master/Modding/Workflow.md)

## Instructions

1) Rename venworks-template.code-workspace to be what ever your repo is named for example in Venworks Core this file is named venworks-core.code-workspace.
2) Edit Tools\sharedConfig.ps1 and replace all occurrences of BOGUS with your namespace and creation name.
3) Create a .ENV file following the instructions in the workflow
4) Edit .github\workflows\package-release.yml and replace all occurrences of BOGUS with your namespace and creation name. Special note once you have manually deployed the package to nexus Mods (Creates the site and file IDs) you can set UPLOAD_TO_NEXUSMODS, make sure you have created GitHub Repository Variables for NEXUSMODS_API_KEY and NEXUSMODS_FILE_ID.
5) Update the README.md this is a weird file I sort of use it as mix of features, issues, and instructions.
6) When you are ready to release update MarketingSites\Nexus\moddetails.bbcode you pretty much need to edit the whole file.

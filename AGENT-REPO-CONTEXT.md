# Repository context

This is the context template for `BOGUS_PROJECT_NAME`. Configure this repository here; `BOGUS_*` values are intentional maintainer placeholders described in [template setup](README-TEMPLATE.md#optional-coding-agent-setup). Unconfigured external services affect only work that needs them. These are repository-owned settings, with no global policy discovery or override system.

## Repository and toolchain

| Setting | Value |
| --- | --- |
| Project name | `BOGUS_PROJECT_NAME` |
| Repository URL | `https://github.com/BOGUS_OWNER_REPLACE_ME/BOGUS_REPO_NAME_REPLACE_ME` |
| Target game | `BOGUS_TARGET_GAME_REPLACE_ME` |

Use the current checkout as the repository path. Verify its remote against the configured repository before publishing. Keep machine-specific paths and secrets in protected local configuration, outside the repository.

The supplied pipeline currently targets Starfield. Other BGS games require appropriate compiler, runtime, and packaging configuration. [README-TEMPLATE.md](README-TEMPLATE.md) is the maintainer's setup and build guide; [Tools/sharedConfig.ps1](Tools/sharedConfig.ps1) owns variant and build configuration and loads the local `.env`. Inspect the selected script and configuration for actual parameters, prerequisites, and side effects before execution.

## Build and verification entry points

Run relevant entry points from the repository root in PowerShell 7, for example `pwsh -NoProfile -File .\Tools\compileScripts.ps1`. Use the configured inputs and tools; do not run every entry point as a generic validation checklist.

| Entry point | Purpose |
| --- | --- |
| [Tools/compileScripts.ps1](Tools/compileScripts.ps1) | Compile configured Papyrus sources using the installed compiler. |
| [Tools/buildScaleform.ps1](Tools/buildScaleform.ps1) | Execute configured Scaleform build jobs; a repository may have none. |
| [Tools/createPackages.ps1](Tools/createPackages.ps1) | Build configured archives from the required inputs and publish packages beneath verified staging junctions. |
| [Tools/checkRepo.ps1](Tools/checkRepo.ps1) | Check configured metadata, artifacts, and staging paths. Its `-Committed` mode does not require destination values or junctions, but initial shared configuration still requires an environment file. |
| [Tools/setupRepo.ps1](Tools/setupRepo.ps1) | Prepare configured staging junctions; this is a maintainer operation, not a routine test. |

Spriggit dump/assembly scripts are optional authoring operations, not required checks for every change. CI's PowerShell analysis does not establish native Papyrus, Scaleform, package, game, or console acceptance. See the [build workflow](README-TEMPLATE.md#build-workflow) and [staging instructions](README-TEMPLATE.md#prepare-staging) for setup details. Downloads, installation, live staging, and authoring changes must be within the task's authorized scope.

PowerShell is the build interface, not a required test language. Invoking the actual compiler provides build evidence; recreating ActionScript behavior in PowerShell does not test the delivered Scaleform code. Missing native tools or game access are explicit validation limits. A compiled script or packaged archive still needs the relevant game/runtime scenario to establish its behavior; apply the shared [verification guidance](AGENTS.md#verification-and-communication).

## GitHub

The target is the repository URL above, verified against the checkout and task. Configure the actual connector or CLI and one supported authentication method. For a GitHub App installation, use evidence of the expected app/installation and repository access. For a dedicated user account, use that connection's supported account-identity check. A user-login check is not universal across authentication methods.

| Setting | Value |
| --- | --- |
| Tool | `BOGUS_GITHUB_TOOL_REPLACE_ME` or `none` when unused |
| Authentication method | `BOGUS_GITHUB_AUTH_METHOD_REPLACE_ME` |
| Expected identity | `BOGUS_GITHUB_IDENTITY_REPLACE_ME` |
| Connection / credential source | `BOGUS_GITHUB_CONNECTION_REPLACE_ME` |
| Verification | `BOGUS_GITHUB_IDENTITY_CHECK_REPLACE_ME` |
| Fallback | None unless explicitly configured for the same identity and target |
| Commit author and committer | `MonsterCookieAI <venworksai@venworkscreations.com>`; replace with the adopting maintainer's chosen automation identity |

Apply commit attribution only to the individual authorized commit command, preserving persistent Git settings. Verify both author and committer in the resulting commit before pushing. Attribution does not establish transport or API identity; follow the shared [identity](AGENTS.md#external-tools-and-identities) and [Git delivery](AGENTS.md#git-and-github-boundaries) boundaries. Unused GitHub integration fields do not block local work.

## Optional issue tracker

| Setting | Value |
| --- | --- |
| Provider | `BOGUS_TRACKER_PROVIDER_REPLACE_ME` or `none` |
| Workspace / organization | `BOGUS_TRACKER_WORKSPACE_REPLACE_ME` or `not applicable` |
| Team / repository scope | `BOGUS_TRACKER_TEAM_REPLACE_ME` or `not applicable` |
| Project scope | `BOGUS_TRACKER_PROJECT_REPLACE_ME` or `not applicable` |
| Tool | `BOGUS_TRACKER_TOOL_REPLACE_ME` or `none` |
| Authentication method | `BOGUS_TRACKER_AUTH_METHOD_REPLACE_ME` or `not applicable` |
| Expected identity | `BOGUS_TRACKER_IDENTITY_REPLACE_ME` or `not applicable` |
| Connection / credential source | `BOGUS_TRACKER_CONNECTION_REPLACE_ME` or `not applicable` |
| Verification | `BOGUS_TRACKER_IDENTITY_CHECK_REPLACE_ME` or `not applicable` |
| Fallback | None unless explicitly configured for the same identity and target |

Use stable identifiers or canonical URLs and only the scopes required by the selected provider. Do not assume UUIDs, a parent/child hierarchy, or specific MCP names or endpoints. For no tracker, set provider and tool to `none` and the remaining configurable tracker fields to `not applicable`.

When an issue governs the task, verify that it belongs to the intended scope and read its requirements, acceptance criteria, relevant discussion, and dependencies. The issue supplies current task requirements; repository source and documentation supply technical contracts and recorded evidence. Resolve material conflicts before dependent work, and refresh issue information when relevant changes may affect the result. A fully specified local request needs no invented issue or tracker bookkeeping.

Use the provider's actual workflow and the user's requested actions. No fixed state transition is required before coding unless the project or task requires it. Resolve real ownership conflicts, but do not treat empty assignments as blockers. Preserve assignee and agent-delegate fields unless changing them is explicitly authorized; connector attribution is separate from ownership. A prepared handoff does not require a status change. Use the shared [external-action boundaries](AGENTS.md#external-tools-and-identities) for comments, updates, and completion, without inventing claims, locks, or substitute tracker state.

### Tracker-derived roadmaps

When requested, select issues using the project's actual statuses, labels, milestones, and the requested criteria; clarify ambiguous selection only when it matters. Preserve scope, dependencies, and meaningful grouping without counting a parent and its children as separate promises for the same outcome. Present a current snapshot, not invented release dates or commitments. Refresh when relevant changes are expected and identify incomplete retrieval. Preparing content does not authorize publication.

## Documentation destinations

Configure destinations by audience and purpose, following the shared [documentation placement rules](AGENTS.md#documentation-placement). Use repository-relative paths or canonical external locations and scope; keep private selectors and credentials outside the repository. An external tracker is optional, and an explicitly selected repository location may hold internal documentation only when its visibility is appropriate for that material.

| Setting | Value |
| --- | --- |
| Public/user documentation | `BOGUS_PUBLIC_DOCS_DESTINATION_REPLACE_ME` |
| Public developer/integration documentation | `BOGUS_INTEGRATION_DOCS_DESTINATION_REPLACE_ME` or the public/user location |
| Internal project documentation | `BOGUS_INTERNAL_DOCS_DESTINATION_REPLACE_ME` |
| Temporary plans, execution notes, and handoffs | Relevant work item when available, otherwise `BOGUS_HANDOFF_DESTINATION_REPLACE_ME` |
| Additional edit restrictions | None by default; list specific files or content and their approval requirements when applicable |

Configure only destinations relevant to the repository. Mark an unused category as `not applicable`; if a later task needs it, establish its destination before persisting content. Do not treat a placeholder as an available destination.

## Credential setup

Use each service's connection / credential source entry above to identify its managed connection or selected credential manager. These are non-secret configuration descriptions, not executable login commands or credential values. Keep private credential selectors and authentication state in protected local configuration and follow the shared [identity boundaries](AGENTS.md#external-tools-and-identities). Credential-manager setup is needed only when an authorized operation cannot use an existing verified connection.

For a service using Proton Pass CLI (`pass-cli`), the bootstrap credential is the protected `PROTON_PASS_PERSONAL_ACCESS_TOKEN` environment variable supplied by local setup. It is separate from the downstream service credential and must never be stored as a Proton Pass item or represented by a `pass://` reference. The service's expected identity above names the downstream account or app, not the credential-manager session. Optional token-name metadata is not a prerequisite for a healthy session.

For authorized setup or recovery, consult the installed CLI's help and current provider documentation, such as the [Proton Pass CLI documentation](https://protonpass.github.io/pass-cli/). Use task-owned session state without logging out or changing the user's default session. Detailed login, credential-transfer, and cleanup commands depend on the selected tool and local setup; they are not part of the mod-development workflow.

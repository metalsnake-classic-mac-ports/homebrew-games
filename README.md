# MetalSnake's Classic Mac Ports: Homebrew tap

Classic Mac games, rewritten for modern systems.

| Formula | Game |
|---|---|
| `ouro-scout` | [Ouro S.C.Out](https://metalsnake-classic-mac-ports.github.io/Ouro-S.C.Out/): S.C.Out (Kalisto, 1993) |

## Install

    brew install metalsnake-classic-mac-ports/games/ouro-scout

Then start the game with `ouro-scout`. Prebuilt bottles exist for Apple
silicon Macs (macOS 14 and newer) and Linux; elsewhere Homebrew builds the
game from source, which needs a few minutes.

## Updating a formula (maintainers)

Open a pull request with the change: GitHub Actions build and test the
bottles. When the checks are green, run the "brew pr-pull" workflow with the
pull request number (`gh workflow run publish.yml -f pull_request=N`); it
uploads the bottles to GitHub Packages and merges the change.

# nu-devcontainer-helpers

A set of [Nushell](https://www.nushell.sh/) scripts for interacting with [Devcontainers](https://containers.dev/) created by Visual Studio Code and running via [Podman](https://podman.io/). The scripts let you use tools installed in the devcontainer, such as OpenCode, Yazi, or LazyGit, directly from your terminal.

The `devbox-enter` command provides an alternative to `devcontainer exec bash` for Podman-hosted devcontainers and requires no additional configuration.

## Purpose

This project addresses several common limitations:

1. The `devcontainer` command-line application assumes Docker by default. Although it can be configured to use Podman, doing so requires additional setup.
2. The `devcontainer` application is not required to interact with an already-running devcontainer; `podman` can be used directly.
3. Devcontainers created by Visual Studio Code run under the `vscode` user rather than your local user account, so the user must be specified in Podman commands.
4. Each time a devcontainer is reopened, it receives a new, randomly generated name.
5. The commands required to identify and enter the appropriate devcontainer can be difficult to remember.

## Features

This project provides the following Nushell commands (found in `devbox.nu`):

*   **`devbox-id`**: Returns the name of the running devcontainer associated with the current working directory. It determines this by inspecting running Podman containers and matching the `devcontainer.local_folder` label.
*   **`devbox-enter`**: Opens an interactive `bash` shell as the `vscode` user inside the devcontainer associated with the current folder.

## Prerequisites

*   [Nushell](https://www.nushell.sh/)
*   [Podman](https://podman.io/)
*   [Devcontainers](https://containers.dev/) (running locally via Podman)

## Assumptions

1. You are running Nushell as your shell.
2. Your devcontainer is created in Visual Studio Code.
3. Your devcontainer has the Bash shell installed.

## Installation

Copy the file `devbox.nu` to your `~/.config/nushell/autoload` folder. Then restart Nushell. After that, the commands `devbox-id` and `devbox-enter` will be available.

Alternatively, you can load these definitions into your Nushell session by running:

```nushell
source devbox.nu
```

## Usage

Once loaded, navigate to any project folder where its devcontainer is running, and run:

```nushell
# Get the container name
devbox-id

# Enter the container's Bash shell
devbox-enter
```

## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.

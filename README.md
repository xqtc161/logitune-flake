# logitune-flake

Nix flake for [logitune](https://github.com/mmaher88/logitune), a Linux configurator for Logitech devices.

## Usage

### Run without installing

```sh
nix run github:xqtc161/logitune-flake
```

### Install via NixOS or home-manager

Add the flake as an input:

```nix
inputs.logitune-flake.url = "github:xqtc161/logitune-flake";
```

Then add the package:

```nix
environment.systemPackages = [ inputs.logitune-flake.packages.${system}.default ];
# or for home-manager:
home.packages = [ inputs.logitune-flake.packages.${system}.default ];
```

### Install ad-hoc

```sh
nix profile install github:xqtc161/logitune-flake
```

## Notes

- udev rules are not automatically installed via this flake. Without them, logitune may not have permission to access your devices. Add the rules from the upstream repo to your NixOS config or install them manually.
- The flake tracks the latest stable release and is updated automatically via a daily GitHub Actions workflow.

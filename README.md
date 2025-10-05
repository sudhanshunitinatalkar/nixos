# NixOS Configuration

This repository contains my personal NixOS system configuration using Flakes.


## Usage

To rebuild the system:

```bash
sudo nixos-rebuild switch --flake .#cosmmos #your hostname
```

## Features

- Declarative system configuration
- Reproducible builds
- Version controlled system state
- Modular design

## Requirements

- NixOS with Flakes enabled
- Git


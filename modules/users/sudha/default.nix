{ inputs, config, lib, ... }:
{
  # 1. Define the actual Home Manager output you will switch to
  flake.homeConfigurations."sudha" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
    extraSpecialArgs = { inherit inputs; };
    modules = [
      config.flake.homeModules.sudha
      config.flake.homeModules.ssh
      config.flake.homeModules.zen-browser
    ];
  };

  # 2. Define your base user configuration module
  flake.homeModules.sudha = { pkgs, ... }: {


    nixpkgs.config.allowUnfree = true;
    # REQUIRED for standalone Home Manager
    home.username = "sudha";
    home.homeDirectory = "/home/sudha";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      tree util-linux vim wget curl git gptfdisk htop fastfetch
      android-tools sops pciutils mosquitto nixd nil
      cloudflared prusa-slicer libreoffice-fresh telegram-desktop
      vlc obs-studio cachix vscode python3 stm32cubemx minicom freecad impression
    ];

    programs.git = {
      enable = true;
      settings.user = {
        name = "sudhanshunitinatalkar";
        email = "atalkarsudhanshu@proton.me";
      };
    };
  };
}
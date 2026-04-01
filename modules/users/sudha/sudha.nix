{ inputs, config, lib, pkgs, ... }:
{
  flake.homeModules.sudha = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    # REQUIRED for standalone Home Manager
    home.username = "sudha";
    home.homeDirectory = "/home/sudha";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      tree 
      util-linux 
      vim 
      wget 
      curl 
      git 
      gptfdisk 
      htop 
      fastfetch
      android-tools 
      sops 
      pciutils 
      mosquitto 
      nixd 
      nil
      cloudflared 
      cachix 
      python3 
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
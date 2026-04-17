{ inputs, config, lib, pkgs, ... }:
{
  # Added 'inputs' to the argument list here
  flake.homeModules.sudha = { pkgs, inputs, ... }: {
    nixpkgs.config.allowUnfree = true;

    # REQUIRED for standalone Home Manager
    home.username = "sudha";
    home.homeDirectory = "/home/sudha";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    # COMBINED LIST: All packages go inside this single block
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
      vscode
      telegram-desktop
      libreoffice-fresh
      spotify
      droidcam
      
      # Zen Browser pulled into the main list
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default 
    ];

    programs.git = {
      enable = true;
      settings.user = {
        name = "sudhanshunitinatalkar";
        email = "atalkarsudhanshu@proton.me";
      };
    };
    
    # This manually links the Plasma bridge into Zen's config folder
    home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = 
      "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
  };
}
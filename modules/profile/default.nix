{
  flake.nixosModules.plasma = { pkgs, inputs, ... }:

  {

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      
      users.sudha = {
        home.stateVersion = "25.11";

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
          prusa-slicer
          libreoffice-fresh
          telegram-desktop
          vlc
          obs-studio
          cachix
          vscode
        ];   

        programs.git = {
          enable = true;
          settings.user = {
            name = "sudhanshunitinatalkar";
            email = "atalkarsudhanshu@proton.me";
          };
        };
      };
    };
  };
}
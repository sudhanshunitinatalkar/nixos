{
  flake.nixosModules.plasma = { pkgs, inputs, ... }:

  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
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
          kdePackages.isoimagewriter
          arduino-ide
          python3
          stm32cubemx
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
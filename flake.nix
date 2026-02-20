{
  description = "cosmos";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = 
    {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    openclaw.url = "github:openclaw/nix-openclaw";
  };

  outputs = inputs@{ nixpkgs, home-manager, zen-browser, openclaw, ... }:
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem     {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = 
      [
        home-manager.nixosModules.home-manager
        ./host/configuration.nix
        ./modules/nvidia
        ./modules/gnome
        {
          nixpkgs.config.allowUnfree = true;
          
          # UPDATED OVERLAY BLOCK
          # In nixos/flake.nix
          # Use the official overlay to cleanly populate pkgs.openclawPackages.withTools
          # In flake.nix under nixpkgs.overlays
          nixpkgs.overlays = [
            (inputs.openclaw.overlays.default or inputs.openclaw.overlays.openclaw)
          ];

          time.timeZone = "Asia/Kolkata";
          time.hardwareClockInLocalTime = true;
          system.stateVersion = "25.11";

          users.users.sudha = 
          {
            isNormalUser = true;
            extraGroups = [ "wheel" "dialout" "docker"];
          };
          nix.settings.trusted-users = [ "root" "sudha" ];
          
          home-manager = 
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.sudha = {
               imports = [ 
                 ./home/sudha.nix 
                 openclaw.homeManagerModules.openclaw               
               ];
               home.stateVersion = "25.11";
            };
          };
        }
      ];
    };
  };
}

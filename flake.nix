{
  description = "cosmos";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = 
    {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem 
    {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = 
      [
        home-manager.nixosModules.home-manager
        ./host/configuration.nix

        ./modules/hardware/nvidia.nix
        ./modules/plasma.nix
        ./modules/steam.nix
        ./modules/thingsboard.nix

        ({ config, pkgs, ... }: 
        {
          time.timeZone = "Asia/Kolkata";
          system.stateVersion = "25.05";

          users.users.sudhanshu = 
          {
            isNormalUser = true;
            extraGroups = [ "wheel" "dialout" ];
          };

          home-manager = 
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.sudhanshu = 
            {
               imports = [ ./home/home.nix ];
               home.stateVersion = "25.05";
            };
          };
        })
      ];
    };
  };
}
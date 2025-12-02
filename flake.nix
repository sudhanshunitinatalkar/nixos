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
        ./modules/gnome.nix
        ({ config, pkgs, ... }: 
        {
          nixpkgs.config.allowUnfree = true;

          time.timeZone = "Asia/Kolkata";
          system.stateVersion = "25.11";

          users.users.sudha = 
          {
            isNormalUser = true;
            extraGroups = [ "wheel" "dialout" ];
          };

        
          home-manager = 
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.sudha = {
               imports = [ ./home/home.nix ];
               home.stateVersion = "25.11";
            };
          };
        })
      ];
    };
  };
}

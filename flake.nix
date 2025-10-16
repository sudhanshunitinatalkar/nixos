{
  description = "cosmos";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = 
    {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = 
    {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, sops-nix, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    stateVersion = "25.05";
  in
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem
    {
      inherit pkgs;
      modules = 
      [
        { 
          system.stateVersion = stateVersion;
        }
        ./modules/nvidia.nix
        ./hosts/cosmos/configuration.nix
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cosmicdust = 
          {
            imports = [./users/cosmicdust/home.nix];
            home.stateVersion = stateVersion; 
          };
        }
      ];
    };

    homeConfigurations."cosmicdust" = home-manager.lib.homeManagerConfiguration
    { 
      inherit pkgs;
      modules = 
      [ 
        { 
          home.stateVersion = stateVersion; 
        }
        sops-nix.nixosModules.sops 
        ./users/cosmicdust/home.nix
      ];
    };

  };
}

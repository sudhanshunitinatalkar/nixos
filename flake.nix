{
  description = "A simple NixOS flake";

  inputs = 
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = 
    {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    stateVersion = "25.05";
  in
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem 
    {
      modules = 
      [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.cosmicdust = 
          {
            imports = [ ./users/cosmicdust/home.nix ];
            home.stateVersion = stateVersion;
          };
        }
      ];
    };

    homeConfigurations.cosmicdust = home-manager.lib.homeManagerConfiguration 
    {
      inherit pkgs;
      modules = 
      [ 
        ./users/cosmicdust/home.nix 
        { home.stateVersion = stateVersion; }
      ];
    };

  };
}
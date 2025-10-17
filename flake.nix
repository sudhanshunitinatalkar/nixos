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


  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs 
    {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem
    {
      modules = 
      [
        home-manager.nixosModules.home-manager
        nixpkgs.nixosModules.readOnlyPkgs
        { nixpkgs.pkgs = pkgs; }
        ./modules/plasma.nix
        ./modules/steam.nix
        ./hosts/cosmos/configuration.nix
        ./users/cosmicdust/cosmicdust.nix      
      ];
    };
  };
}
c
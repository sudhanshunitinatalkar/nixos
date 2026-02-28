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
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, zen-browser, disko, ... }:
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem     {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = 
      [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko 
        ./modules/configuration
        ./modules/profile
        ./modules/ssh
        ./modules/nvidia
        ./modules/plasma
        # ./modules/disko
      ];
    };
  };
}

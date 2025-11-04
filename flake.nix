{
  description = "cosmos";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = 
    {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem
    {
      modules = 
      [
        home-manager.nixosModules.home-manager
        ./modules/hardware/nvidia.nix
        ./modules/plasma.nix
        ./modules/steam.nix
        ./hosts/cosmos/configuration.nix
        ./users/sudhanshu/sudhanshu.nix      
      ];
    };
  };
}

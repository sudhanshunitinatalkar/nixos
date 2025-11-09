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

      home-manager = 
      {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.sudhanshu = 
        {
          imports = [ ./home/home.nix ];
        };

      };

      users.users.sudhanshu = 
      {
        isNormalUser = true;
        extraGroups = [ "wheel" "dialout" ];
      };
      
      modules = 
      [
        home-manager.nixosModules.home-manager
        ./modules/hardware/nvidia.nix
        ./modules/plasma.nix
        ./modules/steam.nix
        ./modules/thingsboard.nix
        ./host/configuration.nix
      ];
    };
  };
}

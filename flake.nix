{
  description = "cosmos";

  inputs = 
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = 
    {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-unstable, ... }:
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

          users.users.sudhanshu = 
          {
            isNormalUser = true;
            extraGroups = [ "wheel" "dialout" ];
          };

          nix.settings.trusted-users = [ "sudhanshu" ];
        
          home-manager = 
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.sudhanshu = {
               imports = [ ./home/home.nix ];
               home.stateVersion = "25.11";
            };
          };
        })
      ];
    };
  };
}

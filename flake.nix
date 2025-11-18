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
  {
    # --- Your Original NixOS Configuration ---
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
        
        ({ config, pkgs, ... }: 
        {
          # Added to ensure NixOS also allows unfree
          nixpkgs.config.allowUnfree = true;

          time.timeZone = "Asia/Kolkata";
          system.stateVersion = "25.11";

          users.users.sudhanshu = 
          {
            isNormalUser = true;
            extraGroups = [ "wheel" "dialout" ];
          };

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

    # Usage: nix run home-manager -- switch --flake .#sudhanshu
    homeConfigurations."sudhanshu" = 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs 
      {
        inherit system;
        config.allowUnfree = true;
      };
    in 
    home-manager.lib.homeManagerConfiguration 
    {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home/home.nix
        {
          home.stateVersion = "25.11";
          home.username = "sudhanshu";
          home.homeDirectory = "/home/sudhanshu";
        }
      ];
    };
  };
}
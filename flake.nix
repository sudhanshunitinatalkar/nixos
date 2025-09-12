{
  description = "Cosmos NixOS Monorepo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # or whatever stable release you're on
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # This ensures Home Manager uses the same nixpkgs as your system
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem {
      inherit system;
      # This is the "correct" way that resolves the warning
      modules = [
        # Explicitly tell NixOS which pkgs to use
        { nixpkgs.pkgs = pkgs; }

        # Import the main configuration for our host "cosmos"
        ./hosts/cosmos/default.nix

        # Make Home Manager available as a module
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
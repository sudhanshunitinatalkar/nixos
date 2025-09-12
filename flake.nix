{
  description = "NixOS System Configuration for Cosmos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    # Define our package set once for the whole system
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; # Allow unfree packages here
    };
  in
  {
    nixosConfigurations.cosmos = nixpkgs.lib.nixosSystem {
      inherit system;
      # This is the old way that causes the warning
      # specialArgs = { inherit pkgs; };

      # This is the new, "correct" way
      modules = [
        { nixpkgs.pkgs = pkgs; } # Explicitly tell NixOS which pkgs to use
        ./hosts/cosmos/default.nix
      ];
    };
  };
}
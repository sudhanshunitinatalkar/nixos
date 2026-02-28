{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmos" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = builtins.attrValues config.flake.nixosModules; 
  };
}
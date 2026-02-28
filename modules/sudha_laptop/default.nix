{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmos" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.disko.nixosModules.disko
    ] 
    ++ builtins.attrValues config.flake.nixosModules; 
  };
}
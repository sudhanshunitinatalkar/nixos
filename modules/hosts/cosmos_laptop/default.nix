{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmos_laptop" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      config.flake.nixosModules.cosmos_laptop
      config.flake.nixosModules.cosmos_laptop_hardware 
      config.flake.nixosModules.nvidia
      config.flake.nixosModules.plasma      
    ];
  };
}
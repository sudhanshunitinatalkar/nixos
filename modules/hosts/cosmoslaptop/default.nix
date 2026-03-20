{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmoslaptop" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      config.flake.nixosModules.cosmoslaptop
      config.flake.nixosModules.cosmoslaptophardware 
      config.flake.nixosModules.nvidia
      config.flake.nixosModules.plasma
      config.flake.nixosModules.mac-style-plymouth      
    ];
  };
}
{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmoslaptop" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      config.flake.nixosModules.cosmos-laptop
      config.flake.nixosModules.cosmos-laptop-hardware 
      config.flake.nixosModules.lenovo-ideapad-gaming3-nvidia
    ];
  };
}

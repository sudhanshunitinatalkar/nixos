{ inputs, config, ... }: 
{
  flake.nixosConfigurations."cosmos-wsl" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.nixos-wsl.nixosModules.default
      config.flake.nixosModules.cosmos-wsl
      config.flake.nixosModules.nixos-wsl-nvidia
    ];
  };
}

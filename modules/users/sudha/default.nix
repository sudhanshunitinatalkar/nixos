{ inputs, config, ... }:

{
  flake.homeConfigurations.sudha = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${builtins.currentSystem or "x86_64-linux"};
    extraSpecialArgs = { inherit inputs; };
    modules = [
      config.flake.homeModules.sudha
    ];
  };
}

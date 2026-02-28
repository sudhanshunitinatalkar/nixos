{ inputs, config, ... }: 
{
  # We tell the Flake: "I am building a NixOS Configuration named 'cosmos'"
  flake.nixosConfigurations."cosmos" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    
    modules = [
      # 1. The Core Engines
      inputs.home-manager.nixosModules.home-manager
      inputs.disko.nixosModules.disko
    ] 
    # 2. THE MAGIC AUTO-IMPORTER
    # This automatically grabs EVERY feature module you defined in Step 2
    # (plasma, nvidia, ssh, etc.) and injects them into the laptop!
    ++ builtins.attrValues config.flake.nixosModules; 
  };
}
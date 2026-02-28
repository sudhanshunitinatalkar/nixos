{
  flake.nixosModules.zen-browser = { pkgs, inputs, ... }: {
    
    home-manager.users.sudha = {
      home.packages = [
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
      ];
    };

  };
}
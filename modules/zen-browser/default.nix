{
  flake.nixosModules.zen-browser = { pkgs, inputs, ... }: {
    home-manager.users.sudha = {
      home.packages = [ 
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default 
      ];

      # This manually links the Plasma bridge into Zen's config folder
      home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = 
        "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
    };
  };
}
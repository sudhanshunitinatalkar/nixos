{
  flake.nixosModules.plasma = { pkgs, inputs, ... }:

  {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "breeze";
      wayland.enable = true; 
      settings = {
        General = {
          GreeterEnvironment = "QT_SCALE_FACTOR=1.1";
        };
      };
    };
  };

  environment.systemPackages = with pkgs.kdePackages;
    [
      plasma-browser-integration
      kcalc 
      kcharselect 
      kclock 
      kcolorchooser 
      kolourpaint 
      ksystemlog 
      isoimagewriter 
      partitionmanager 
      isoimagewriter
      filelight
      kdeconnect-kde
      ktorrent
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

}
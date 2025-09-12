# modules/system/configuration.nix
{ pkgs, ... }: 
{
  imports = 
  [
    ./packages.nix
    ./services.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # Define the default user
  users.users.cosmicdust = 
  {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
  };

  system.stateVersion = "25.05";
}
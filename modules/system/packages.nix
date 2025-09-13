# modules/system/packages.nix
{ pkgs, ... }: {
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; 
  [
    vim
    wget
    curl
    git
    docker
    docker-compose
    kdePackages.sddm-kcm
  ];

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
}
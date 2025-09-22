# modules/home/cosmos.nix
{ pkgs, ... }:
{
  home-manager.users.cosmicdust = {
    home.packages = with pkgs; 
    [
        blender
        freecad
        kicad
        vscode
        arduino-ide
        prusa-slicer
        libreoffice-fresh
        discord
        telegram-desktop
        steam
        steam-run
        element-desktop
        obs-studio
        gimp
        inkscape
        vlc
        neofetch
        cheese
        rpi-imager
        kdePackages.isoimagewriter
        kdePackages.ktorrent
        joplin-desktop
        tree
    ];

    programs.git = 
    {
      enable = true;
      userName = "sudhanshunitinatalkar";
      userEmail = "atalkarsudhanshu@oroton.me";
    };

    home.stateVersion = "25.05";
  };
}
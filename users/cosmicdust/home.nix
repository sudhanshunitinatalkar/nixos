{ pkgs, ... }:

{
    home.packages = with pkgs; 
    [
        tree
        vscode
        arduino-ide
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        discord
        gimp
        inkscape
        vlc
        cheese
        rpi-imager
        kdePackages.ktorrent
        kdePackages.isoimagewriter
    ];

   home.stateVersion = "25.05";
}
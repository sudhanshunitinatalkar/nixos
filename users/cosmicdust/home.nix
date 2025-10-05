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


  programs.git = 
  {
    enable = true;
    userName = "sudhanshunitinatalkar";
    userEmail = "atalkarsudhanshu@proton.me";
  };


   home.stateVersion = "25.05";
}
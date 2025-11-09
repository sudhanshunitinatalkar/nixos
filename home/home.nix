{ pkgs, ... }:

{
    home.packages = with pkgs; 
    [
        tree
        util-linux
        vim
        wget
        curl
        git
        gptfdisk
        htop
        fastfetch
        android-tools
        sops
        pciutils
        home-manager
  
        cloudflared
        vscode
        arduino-ide
        python3
        kicad
        freecad
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        discord
        gimp
        inkscape
        vlc
        cheese
        rpi-imager
        mosquitto
        kdePackages.ktorrent
        kdePackages.isoimagewriter
    ];


  programs.git = 
  {
    enable = true;
    userName = "sudhanshunitinatalkar";
    userEmail = "atalkarsudhanshu@proton.me";
  };
}
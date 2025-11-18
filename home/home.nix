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
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };
}
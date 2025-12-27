{ pkgs, inputs, ... }:

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
        mosquitto
        python3
  
        cloudflared
        arduino-ide
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        gimp
        inkscape
        vlc
        fragments
        zed-editor
        rpi-imager
        obs-studio
        freecad
        kicad
    ];


  programs.git = 
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };

}

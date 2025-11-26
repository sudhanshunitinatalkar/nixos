{ pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in

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
        arduino-ide
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        gimp
        inkscape
        vlc
        unstable.vscodium
    ];


  programs.git = 
  {
    enable = true;
    userName = "sudhanshunitinatalkar";
    userEmail = "atalkarsudhanshu@proton.me";
  };

}

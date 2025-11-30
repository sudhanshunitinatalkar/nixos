{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable 
  {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
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
        mosquitto
        python3
  
        cloudflared
        unstable.arduino-ide
        unstable.prusa-slicer
        unstable.libreoffice-fresh
        unstable.telegram-desktop
        unstable.gimp
        unstable.inkscape
        unstable.vlc
        unstable.fragments
        unstable.vscode
        rpi-imager
        unstable.obs-studio
        kdePackages.isoimagewriter
         
      
    ];


  programs.git = 
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };

}

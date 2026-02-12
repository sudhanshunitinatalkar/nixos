{ pkgs, ... }:

{
  
  imports =
  [
    ./gnome.nix
    ./ssh.nix
  ];
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
        nixd
        nil
        inotify-tools

        cloudflared
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        vlc
        fragments
        zed-editor
        obs-studio
        scribus
        cachix
        mqttx
    ];   

  programs.git =
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };
  

}

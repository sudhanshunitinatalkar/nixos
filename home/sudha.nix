{ pkgs, inputs, ... }:

{
  
  imports =
  [
    ./gnome.nix
    ./ssh.nix
  ];
    home.packages = with pkgs;
    [
        inputs.openclaw.packages.${pkgs.system}.openclaw
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
        cachix
        mqttx
        arduino-ide
        impression
    ];   

  programs.git =
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };
  
}

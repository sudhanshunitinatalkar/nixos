{ pkgs, inputs, ... }:

{
  
  
  imports =
  [
    ./ssh.nix
  ];
    home.packages = with pkgs;
    [
        # inputs.openclaw.packages.${pkgs.system}.openclaw
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
        nixd
        nil

        cloudflared
        prusa-slicer
        libreoffice-fresh
        telegram-desktop
        vlc
        obs-studio
        cachix
        vscode
    ];   

  programs.git =
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };
  
 
  
}

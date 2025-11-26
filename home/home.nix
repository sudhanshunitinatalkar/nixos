{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable 
  {
    system = pkgs.system;
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
        unstable.zed-editor
        unstable.brave
        
        nil
        nixd
        ruff
    ];


  programs.git = 
  {
    enable = true;
    userName = "sudhanshunitinatalkar";
    userEmail = "atalkarsudhanshu@proton.me";
  };

}

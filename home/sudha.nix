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
        mosquitto
        python3
        nixd
        nil
  
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
        freetube
        attic-client
        kdePackages.isoimagewriter
        scribus
        cachix

    ];
    
    programs.ssh = 
    {
      enable = true;
      enableDefaultConfig = false; 
      matchBlocks = 
      {
        "*" = 
        {
          addKeysToAgent = "yes"; 
        };
        "pbrserver.eltros.in" = 
        {
          user = "pbr";
          proxyCommand = "cloudflared access ssh --hostname %h";
        };
      };
    };
    
    
  programs.git = 
  {
    enable = true;
    settings.user.name = "sudhanshunitinatalkar";
    settings.user.email = "atalkarsudhanshu@proton.me";
  };

}

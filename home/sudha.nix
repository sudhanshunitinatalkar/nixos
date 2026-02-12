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
        "pbrlab.eltros.in" =
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

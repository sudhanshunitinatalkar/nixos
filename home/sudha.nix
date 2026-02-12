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


    xdg.configFile."monitors.xml".text = ''
    <monitors version="2">
      <configuration>
        <layoutmode>logical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1.25</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>eDP-1</connector>
              <vendor>LEN</vendor>
              <product>0x9059</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>1920</width>
              <height>1080</height>
              <rate>120.002</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';

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

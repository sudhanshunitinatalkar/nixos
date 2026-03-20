{
  flake.nixosModules.cosmos_laptop = { inputs, pkgs, ... }:
  {
    nix.settings = 
    {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "sudha" ];
    };
    system.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;

    boot =
    {
      binfmt.emulatedSystems = [ "aarch64-linux" ];
      kernelPackages = pkgs.linuxPackages_latest;
      
      loader =
      {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      loader.timeout = 0;

      # --- Plymouth & Silent Boot Configuration ---
      plymouth = {
        enable = true;
        theme = "rings";
        themePackages = with pkgs; [
          # Installs the specific 'rings' theme from adi1090x's collection
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "rings" ];
          })
        ];
      };

      # Enable "Silent boot" so text doesn't interrupt the animation
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };

    hardware.bluetooth.enable = true;

    networking =
    {
      hostName = "cosmos_laptop";
      networkmanager.enable = true;
      firewall.enable = false;
      # firewall.allowedTCPPorts = [ ];
      # firewall.allowedUDPPorts = [ ];
    };

    users.users.sudha = 
    {
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "docker"];
    };

    time = {
      timeZone = "Asia/Kolkata";
    };
    
    services =
    {
      printing.enable = true;
      ollama = {
        enable = true;
        package = pkgs.ollama-cuda;
      };

      pipewire =
      {
        enable = true;
        pulse.enable = true;
      };
      timesyncd.enable = true;
      openssh.enable = true;
    };

    environment.systemPackages = with pkgs;
    [
      tree
      util-linux
      vim
      wget
      curl
      git
      gptfdisk
      htop
      pciutils
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console =
    {
      keyMap = "us";
    }; 

  };
}

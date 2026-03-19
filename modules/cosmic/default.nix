{
    flake.nixosModules.cosmic = { pkgs, ... }:

    {
        services = {
            desktopManager.cosmic.enable = true;
            displayManager.cosmic-greeter.enable = true;
            system76-scheduler.enable = true;
        };

        environment.sessionVariables = {
            # Bypasses strict Wayland security so your clipboard works globally
            COSMIC_DATA_CONTROL_ENABLED = "1";
            
            # Forces Electron apps (VSCode, etc.) to use Wayland natively, eliminating XWayland stutter
            NIXOS_OZONE_WL = "1";
        };

        environment.systemPackages = with pkgs; [
            # Essential Wayland utilities
            wl-clipboard
            wayland-utils
        ];
    };
}
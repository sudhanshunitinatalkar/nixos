{
    flake.nixosModules.cosmic = { pkgs, ... }:

    {
        services = {
            desktopManager.cosmic.enable = true;
            displayManager.cosmic-greeter.enable = true;
            system76-scheduler.enable = true;
        };

        environment.sessionVariables = {            
            NIXOS_OZONE_WL = "1";
        };

    };
}
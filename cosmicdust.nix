{ pkgs, ... }:

{
    users.users.cosmicdust =
    {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs;
        [
            tree
            vscode
            arduino-ide
            prusa-slicer
            libreoffice-fresh
            telegram-desktop
            discord
            gimp
            inkscape
            vlc
            cheese
            rpi-imager
            kdePackages.ktorrent
            kdePackages.isoimagewriter
        ];
   };
}
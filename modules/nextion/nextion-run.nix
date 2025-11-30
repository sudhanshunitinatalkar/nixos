{ config, pkgs, ... }:

let
  # Define the specific Wine package (Staging is best for compatibility)
  winePkg = pkgs.wineWowPackages.staging;

  # The wrapper script based on your working manual commands
  nextion-run = pkgs.writeShellScriptBin "nextion-run" ''
    # 1. Define the Prefix location exactly as you requested (~/.wine-nextion)
    export WINEPREFIX="$HOME/.wine-nextion"
    export WINEARCH=win32
    
    # Force Winetricks to use this specific Wine version to avoid "version mismatch" errors
    export WINE="${winePkg}/bin/wine"

    # 2. Setup: If the folder doesn't exist, run the setup commands
    if [ ! -d "$WINEPREFIX" ]; then
       echo "----------------------------------------------------------"
       echo "Setting up ~/.wine-nextion (32-bit)..."
       echo "Running: winetricks -q dotnet35sp1 corefonts"
       echo "----------------------------------------------------------"
       
       # Ensure clean state
       ${winePkg}/bin/wineserver -k
       
       # Initialize the prefix (matches 'winecfg' first run behavior)
       ${winePkg}/bin/wineboot -u
       
       # Install dependencies (matches your manual command)
       ${pkgs.winetricks}/bin/winetricks -q dotnet35sp1 corefonts
    fi

    # 3. Run the application
    # Ensure no lingering processes from other prefixes interfere
    ${winePkg}/bin/wineserver -k
    
    exec ${winePkg}/bin/wine "$@"
  '';
in
{
  environment.systemPackages = [
    nextion-run
    pkgs.winetricks
  ];
}
{ config, pkgs, inputs, ... }:

let
  # The "Context Switcher" Script
  # It explicitly uses the Unstable Staging binary to guarantee bleeding edge features.
  nextion-run = pkgs.writeShellScriptBin "nextion-run" ''
    # 1. Set the Isolated Environment
    export WINEPREFIX="$HOME/.local/share/wineprefixes/nextion"
    export WINEARCH=win32
    
    # 2. Informative check (optional, helps debugging)
    if [ ! -d "$WINEPREFIX" ]; then
       echo "--- Creating new Nextion Prefix (32-bit) ---"
       echo "Path: $WINEPREFIX"
    fi

    # 3. Run the command using the BLEEDING EDGE Wine
    # We use 'exec' to replace this script process with Wine
    exec ${wineWowPackages.staging}/bin/wine "$@"
  '';
in
{
  # Install the packages globally (System-wide)
  environment.systemPackages = [
    nextion-run
  ];
}
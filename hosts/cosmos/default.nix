# hosts/cosmos/default.nix
{ ... }: 
{
  imports = 
  [
    # Import the main system configuration
        ./hardware-configuration.nix
    ../../modules/system/configuration.nix
    ../../modules/hardware/nvidia.nix

    ../../modules/home/cosmos.nix 
  ];

  # Define the hostname for this specific machine
  networking.hostName = "cosmos";
}
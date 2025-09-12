# modules/system/services.nix
{ ... }: 
{
  # Services configuration
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.printing.enable = true;
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.openssh.enable = true;
  services.cloudflared.enable = true;

  # Firewall configuration for KDE Connect
  networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
}
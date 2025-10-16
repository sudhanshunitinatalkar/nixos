{ pkgs, ... }:

{
  users.users.cosmicdust = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
  };

  home-manager.users.cosmicdust = {
    imports = [ ../../users/cosmicdust/home.nix ];
  };
}